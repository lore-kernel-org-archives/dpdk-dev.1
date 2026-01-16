Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8368D4A607
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:57:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C00E342D87;
	Fri, 16 Jan 2026 07:57:57 +0100 (CET)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 3B1B94060F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:57:56 +0100 (CET)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-655afbca977so360420a12.2
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768546676;
 x=1769151476; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyyNHBwDsN0Jeap6UKjqQFe6BImwF1H3L4ZILxbCnA8=;
 b=wgAGojPoBebhmZzYdoWXh3QUt03PEI4ZMX2+BKlLENK3Ff3N8aO3oWUTwppCjageXn
 zDWzjNgtYGK2RGdTmgCZssl670uOYaTZ1ES52SoJU+rtn8Oiqz9OrRpvo0+OZOiNEQlk
 2bUrnOIhFGtFd1WFbJ1f6Oz/uWVWBWrK7IqCELK3n6kLtlIAfWK0ZWKW6ZG4LzvNCND+
 zlBrWMHE4SvZwzl39sXBcHtCRoHeNdkDWbvmBcSJD1Pi1jXn4rIBirF52YIljns5FpwS
 PZcWepTFmJOMj3kzi0rnJsxyqQB6dlcQCCa+yHLQ+EygoteLy9qszBzoz5N/SLm8O/oH
 o6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768546676; x=1769151476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VyyNHBwDsN0Jeap6UKjqQFe6BImwF1H3L4ZILxbCnA8=;
 b=ECp/7sozxaCGhIY6EmyLlklUM6zvGcMmox2Z9xxCa3Gw8wzQ1NF+lp/6F7eve9/OgS
 2oWRlcSpCFLVnWgjfccvKHAYEP5g4PmaqXtJXMiu8XnisHW64ulR61T665RZxL4XXgzk
 uXZeQhj2x/Ujhq2kfgD76XuPFDAmO1bzRZuofzJwm52J9CbetkUNOdpuN3pkGRBtf8cg
 cYCRug897oyCK9T8we9LWkgdHxMEzVQyAjhBXG86CQRjNsFS8gVzxU/kldSjte72SuvE
 z39KpKLMpXajy1YRmMXsYj+5F3bFQW7TWSqWodHzkXwOpn8NUw/p9wJpOG60U+IiU01G
 wjFA==
X-Gm-Message-State: AOJu0YwZhGMzkEnK1cg+BogUo+YzZnsMyTvC8GNtX0Dh3z+3uEcusw1F
 bSF1LnI+TXl2SWkNfS+nhXghinlKr1NjhZw9g5U/AIn//zH0GKBRvYM52OMtjR0CiY3dDvNNF2o
 aBTNm
X-Gm-Gg: AY/fxX5MIi5OOM9f3n13Y2daD08g1yHV4K+dC6+OXVvh5OZWcUJ63DzHgX798FEYxTZ
 nEHO6I0eDBSrtRUv/dfmhwybOimgGWDODm6zsSciN7ByGheQLD/qkPfj4zO7ij6o6awyJNeHZjo
 AsXyQACxHxLcYaMjK56611nZrsKr+UXD06+sMYpRc7Z1yWFovxc3Mzi73Qd7atJvT1eYh0THmWq
 sV/wCo8aR+Q94dn0xd6dEK0ZF8iN9mC7+yUPd6GA4U8fRCkBOeDiwIqYDRqAIK5igbmAgLTBcWl
 OsPbwzs++hVSG1UbO2BPbhvtpbQy6FY1HFHnG3ojjLLLz22gVHFkeqRIXkjjJlBQv+jwgB08K9/
 KBA12pGRLDD3kQR/fMVcEmvkgGkG4bjP+ex/dtw20OIsqCOWwIJ28gmWJroQ+Z8UsyQwHjDlOd1
 EwrvZPFfMxjc/qAt/GRYU29iFIfAQ9yJACCq7NBdtV2p6TnpjATVNl
X-Received: by 2002:a05:6402:518b:b0:650:5d7e:8a29 with SMTP id
 4fb4d7f45d1cf-65452cd9871mr1444439a12.32.1768546675659; 
 Thu, 15 Jan 2026 22:57:55 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452ddfb76sm1587792a12.15.2026.01.15.22.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:57:54 -0800 (PST)
Date: Thu, 15 Jan 2026 22:57:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/7] Add script for real-time telemetry monitoring
Message-ID: <20260115225750.3a7fe9a3@phoenix.local>
In-Reply-To: <20260115190331.3721281-1-bruce.richardson@intel.com>
References: <20251210165532.103450-1-bruce.richardson@intel.com>
 <20260115190331.3721281-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 15 Jan 2026 19:03:24 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> TL;DR
> ------
>=20
> For a  quick demo, apply patches, run e.g. testpmd and then in a separate
> terminal run:
>=20
>   ./usertools/dpdk-telemetry-watcher.py -d1T eth.tx
>=20
> Output, updated once per second, will be traffic rate per port e.g.:
>=20
> Connected to application: "dpdk-testpmd"
> Time       /ethdev/stats,0.opackets /ethdev/stats,1.opackets        Total
> 16:29:12                  5,213,119                5,214,304   10,427,423
>=20
>=20
> Fuller details
> --------------
>=20
> While we have the dpdk-telemetry.py CLI app for interactive querying of
> telemetry on the commandline, and a telemetry exporter script for
> sending telemetry to external tools for real-time monitoring, we don't
> have an app that can print real-time stats for DPDK apps on the
> terminal. This patchset adds such a script, developed with the help of
> Github copilot to fill a need that I found in my testing. Submitting it
> here in the hopes that others find it of use.
>=20
> The script acts as a wrapper around the existing dpdk-telemetry.py
> script, and pipes the commands to that script and reads the responses,
> querying it once per second. It takes a number of flag parameters, such
> as the ones above:
>  - "-d" for delta values, i.e. PPS rather than total packets
>  - "-1" for single-line output, i.e. no scrolling up the screen
>  - "-T" to display a total column
>=20
> Other flag parameters can be seen by looking at the help output.
>=20
> Beyond the flags, the script also takes a number of positional
> parameters, which refer to specific stats to display. These stats must
> be numeric values, and should take the form of the telemetry command to
> send, followed by a "." and the stat within the result which is to be
> tracked. As above, a stat would be e.g. "/ethdev/stats,0.opackets",
> where we send "/ethdev/stats,0" to telemetry and extract the "opackets"
> part of the result.
>=20
> However, specifying individual stats can be awkward, so some shortcuts
> are provided too for the common case of monitoring ethernet ports. Any
> positional arg starting with "eth" will be replaced by the set of
> equivalent values for each port, e.g. "eth.imissed" will track the
> imissed value on all ports in use in the app. The ipackets and opackets
> values, as common metrics, are also available as shortened values as
> just "rx" and "tx", so in the example above, "eth.tx" means to track the
> opackets stat for every ethdev port.
>=20
> Finally, the script also has reconnection support so you can leave it
> running while you start and stop your application in another terminal.
> The watcher will try and reconnect to a running instance every second.
>=20
> v3:
> Updated following AI review
> - removed unnecessary f-string
> - added documnentation in guides/tools
> - added release note entry
>=20
> v2:
> - improve reconnection handling, eliminating some crashes seen in testing.
>=20
>=20
> Bruce Richardson (7):
>   usertools: add new script to monitor telemetry on terminal
>   usertools/telemetry-watcher: add displaying stats
>   usertools/telemetry-watcher: add delta and timeout opts
>   usertools/telemetry-watcher: add total and one-line opts
>   usertools/telemetry-watcher: add thousands separator
>   usertools/telemetry-watcher: add eth name shortcuts
>   usertools/telemetry-watcher: support reconnection
>=20
>  doc/guides/rel_notes/release_26_03.rst |   7 +
>  doc/guides/tools/index.rst             |   1 +
>  doc/guides/tools/telemetrywatcher.rst  | 184 +++++++++++
>  usertools/dpdk-telemetry-watcher.py    | 435 +++++++++++++++++++++++++
>  usertools/meson.build                  |   1 +
>  5 files changed, 628 insertions(+)
>  create mode 100644 doc/guides/tools/telemetrywatcher.rst
>  create mode 100755 usertools/dpdk-telemetry-watcher.py
>=20
> --
> 2.51.0

AI also had some good feedback on the documentation here.



### Spelling Issues

=E2=9C=93 No spelling errors found.

---

### Grammar Issues

| Line/Section | Issue | Suggestion |
|--------------|-------|------------|
| Options: `-i` | "...when multiple applications are running with the same =
file-prefix." | Consider: "...when multiple applications **share** the same=
 file-prefix." (more concise) |
| Options: `-t` | "Number of iterations to run before stopping." | Should b=
e: "Number of iterations to run before **exiting**." (matches the behavior=
=E2=80=94tool exits, not just stops) |
| Statistics Format | "To discover available commands and fields:" followed=
 by numbered list | The colon introduces an incomplete sentence. Better: "T=
o discover available commands and fields, use the following methods:" or re=
move the colon and use "you can:" |

---

### Technical Writing Style Issues

| Location | Issue | Recommendation |
|----------|-------|----------------|
| Title | "dpdk-telemetry-watcher Application" | Consider: "dpdk-telemetry-=
watcher Tool" =E2=80=94 the word "application" might confuse readers since =
DPDK applications are the *targets* being monitored |
| Opening paragraph | "Data Plane Development Kit (DPDK)" | Unnecessary exp=
ansion=E2=80=94DPDK docs assume readers know what DPDK is. Simplify to just=
 "DPDK" |
| Options: `-d` | "Display delta (incremental) values" | Redundant parenthe=
tical. Use either "delta values" or "incremental values", not both |
| Options: `-d` | "which is useful for monitoring rates of change" | Vague.=
 Better: "which is useful for monitoring per-second rates" |
| Shortcuts section | "These shortcuts automatically detect all available e=
thernet devices" | Should be "Ethernet" (capital E) per DPDK style, or bett=
er: "ethdev ports" to match DPDK terminology |
| Output Format | "Values are formatted with locale-specific number formatt=
ing (e.g., comma separators)." | Awkward repetition of "formatting". Rewrit=
e: "Values use locale-specific formatting (e.g., comma as thousands separat=
or)." |
| Dependencies | "A running DPDK application with telemetry enabled" | Cont=
radicts the "Running the Application" section which says the tool "can be r=
un at any time, whether or not a DPDK application is currently running." Re=
move this item or clarify it's needed for actual monitoring. |

---

### Passive Voice (per DPDK documentation standards)

| Location | Passive Construction | Active Alternative |
|----------|---------------------|-------------------|
| Opening | "Statistics are specified in the format..." | "Specify statisti=
cs in the format..." |
| Output Format | "Values are formatted with..." | "The tool formats values=
 with..." |
| Output Format | "the tool displays the change in each statistic" | =E2=9C=
=93 Already active (good) |

---

### Consistency Issues

| Issue | Details |
|-------|---------|
| "ethernet" vs "Ethernet" | Line uses lowercase "ethernet devices" =E2=80=
=94 DPDK typically uses "Ethernet" or avoids it entirely in favor of "ethde=
v" |
| "file-prefix" hyphenation | Used consistently (good), but DPDK code often=
 uses "file_prefix" =E2=80=94 verify against dpdk-telemetry.py docs |
| Option argument style | Mix of `FILE_PREFIX` (all caps) and `TIMEOUT` (al=
l caps) =E2=80=94 consistent (good) |
| Example commands | Some use full paths (`/ethdev/stats,0.ipackets`), shor=
tcuts (`eth.rx`) =E2=80=94 good variety showing both |

---

### RST Formatting Issues

| Location | Issue | Fix |
|----------|-------|-----|
| Line 1 | `..  SPDX` has two spaces after `..` | Should be single space: `=
.. SPDX` |
| Cross-references | `` `Statistics Format`_ `` and `` `Examples`_ `` | The=
se RST references work but would be more robust as `:ref:` targets for cros=
s-document linking |

---

### Missing Information

| Gap | Suggestion |
|-----|------------|
| No mention of Ctrl+C | Add note that Ctrl+C cleanly exits the monitoring =
loop (already in code) |
| No sample output | Consider adding a brief example of what the output loo=
ks like |
| No error handling description | What happens if a stat doesn't exist? Doc=
ument the error messages |

---

### Suggested Rewrites

**Opening paragraph** (current):
> The ``dpdk-telemetry-watcher`` tool is a Data Plane Development Kit (DPDK=
) utility that provides continuous monitoring of DPDK telemetry statistics =
on the command line. It wraps the ``dpdk-telemetry.py`` script to provide r=
eal-time statistics display capabilities.

**Suggested**:
> The ``dpdk-telemetry-watcher`` tool monitors DPDK telemetry statistics co=
ntinuously on the command line. It wraps ``dpdk-telemetry.py`` to provide r=
eal-time display of selected statistics.

---

**Dependencies section** (current):
> The tool requires:
> * Python 3
> * The ``dpdk-telemetry.py`` script must be available in the same director=
y or in the system PATH
> * A running DPDK application with telemetry enabled

**Suggested**:
> The tool requires:
>=20
> * Python 3
> * The ``dpdk-telemetry.py`` script (in the same directory or in PATH)
>=20
> For monitoring, a DPDK application with telemetry enabled must be running=
, though the watcher can start before the application and will connect auto=
matically.

---

### Summary

| Category | Count |
|----------|-------|
| Grammar issues | 3 |
| Style issues | 7 |
| Passive voice | 2 |
| Consistency issues | 1 |
| RST formatting | 1 |
| Missing information | 3 |

**Overall**: The documentation is functional and reasonably clear. The issu=
es are minor and mostly stylistic. The most important fix is resolving the =
contradiction in the Dependencies section about whether a running DPDK appl=
ication is required.
