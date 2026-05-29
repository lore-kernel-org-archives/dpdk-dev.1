Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329EFCD6E43
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 00:25:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 50EAC40264;
	Fri, 29 May 2026 02:25:33 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id 50BE04021F
 for <dev@dpdk.org>; Fri, 29 May 2026 02:25:31 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=4U0Fomlh3O3J2PYJ15YUIUEH2+hOhFRicteNEcbHNF0=;
 b=0rDMdsq1o2Ra2lsRlFntIAUlF6Cd29I7yaYwHZiNaGCzUT5IGi/bbHpi4GeATZVIo7j057Kop
 XNOlA1z/TXfi+Oxrs1lZdLRkffaEC9453IEIyy8UwdmmqbGOR/M5NiRmro/g9RYq7mc7rHdTSuz
 w6CFClFDusRgQx40juXtV6c=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gRP7m0VSpz1prLM
 for <dev@dpdk.org>; Fri, 29 May 2026 08:17:40 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 3E899201E9
 for <dev@dpdk.org>; Fri, 29 May 2026 08:25:29 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 08:25:28 +0800
Message-ID: <89ca5024-1ffa-4eed-a0d1-6aeb01acf46a@huawei.com>
Date: Fri, 29 May 2026 08:25:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] usertools/telemetry: support using aliases for
 long commands
To: Bruce Richardson <bruce.richardson@intel.com>, <dev@dpdk.org>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260522133714.133268-1-bruce.richardson@intel.com>
 <20260522133714.133268-3-bruce.richardson@intel.com>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260522133714.133268-3-bruce.richardson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.161]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

On 5/22/2026 9:37 PM, Bruce Richardson wrote:
> Similarly to how shell aliases work, allow specifying of short alias
> commands for dpdk-telemetry.py script. The aliases are read from
> "$HOME/.dpdk_telemetry_aliases" at startup.
> 
> Some examples of use from the docs. Alias file contents:
> 
>   # Basic shortcuts
>   ls=/ethdev/list
>   names=FOREACH i /ethdev/list /ethdev/info,$i .name
>   q=quit
> 
> Alias use:
> 
>    --> ls
>   {"/ethdev/list": [0, 1]}
> 
>   --> names
>   [{"i": 0, "name": "0000:
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  doc/guides/howto/telemetry.rst | 34 +++++++++++++++
>  usertools/dpdk-telemetry.py    | 75 ++++++++++++++++++++++++++++++++--
>  2 files changed, 105 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/guides/howto/telemetry.rst b/doc/guides/howto/telemetry.rst
> index 4bf48c635e..072289aec8 100644
> --- a/doc/guides/howto/telemetry.rst
> +++ b/doc/guides/howto/telemetry.rst
> @@ -130,6 +130,40 @@ and query information using the telemetry client python script.
>       - With loop variable: returns an array of objects containing the loop
>         variable field and requested value fields.
>  
> +   * Use command aliases.
> +
> +     The telemetry script can load aliases at startup from::
> +
> +        $HOME/.dpdk_telemetry_aliases

How about add one parameter to specific aliases file location

> +
> +     Each alias entry must be in ``alias=command`` format.
> +     Empty lines and lines starting with ``#`` are ignored.
> +
> +     Example alias file::
> +
> +        # Basic shortcuts
> +        ls=/ethdev/list
> +        names=FOREACH i /ethdev/list /ethdev/info,$i .name
> +        q=quit
> +
> +     Alias behavior is intentionally similar to shell aliases:
> +
> +     - The first token of the entered input is checked for an alias match.
> +     - If matched, that first token is replaced with its expansion.
> +     - Alias expansion is recursive (aliases can expand to other aliases).
> +     - Expansion has a safety limit to prevent infinite loops.
> +
> +     Examples::
> +
> +        --> ls
> +        {"/ethdev/list": [0, 1]}
> +
> +        --> names
> +        [{"i": 0, "name": "0000:16:00.0"}, {"i": 1, "name": "0000:16:00.1"}]
> +
> +        --> q
> +        # exits the client
> +
>  
>  Connecting to Different DPDK Processes
>  --------------------------------------
> diff --git a/usertools/dpdk-telemetry.py b/usertools/dpdk-telemetry.py
> index 2de10cff69..8b976160e0 100755
> --- a/usertools/dpdk-telemetry.py
> +++ b/usertools/dpdk-telemetry.py
> @@ -21,6 +21,70 @@
>  SOCKET_NAME = "dpdk_telemetry.{}".format(TELEMETRY_VERSION)
>  DEFAULT_PREFIX = "rte"
>  CMDS = []
> +ALIASES = {}
> +ALIAS_FILE = ".dpdk_telemetry_aliases"
> +MAX_ALIAS_EXPANSIONS = 32
> +
> +
> +def load_aliases():
> +    """Load aliases from $HOME/.dpdk_telemetry_aliases"""
> +    aliases = {}
> +    home = os.environ.get("HOME")
> +    if not home:
> +        return aliases
> +
> +    alias_path = os.path.join(home, ALIAS_FILE)
> +    if not os.path.isfile(alias_path):
> +        return aliases
> +
> +    try:
> +        with open(alias_path) as alias_file:
> +            for line_num, line in enumerate(alias_file, start=1):
> +                entry = line.strip()
> +                if not entry or entry.startswith("#"):
> +                    continue
> +                if "=" not in entry:
> +                    print(
> +                        "Warning: ignoring malformed alias at {}:{}".format(alias_path, line_num),
> +                        file=sys.stderr,
> +                    )
> +                    continue
> +                name, command = entry.split("=", 1)
> +                name = name.strip()
> +                command = command.strip()
> +                if not name or not command:
> +                    print(
> +                        "Warning: ignoring malformed alias at {}:{}".format(alias_path, line_num),
> +                        file=sys.stderr,
> +                    )
> +                    continue
> +                aliases[name] = command
> +    except OSError as e:
> +        print("Warning: failed to read {}: {}".format(alias_path, e), file=sys.stderr)

If load OK, please add one promote at begin:

Loaded xxx command aliases, see `help alias` for detail

> +
> +    return aliases
> +
> +


