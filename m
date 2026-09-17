Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F99C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 11:15:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD48642E5E;
	Thu, 17 Sep 2026 13:15:30 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 6B8F540299;
 Thu, 17 Sep 2026 13:15:29 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 219701A000F;
 Thu, 17 Sep 2026 13:15:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DFCF71A0008;
 Thu, 17 Sep 2026 13:15:28 +0200 (CEST)
Received: from [92.120.147.87] (wsv03115.swis.in-blr01.nxp.com [92.120.147.87])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0E9BB18000BA;
 Thu, 17 Sep 2026 19:15:26 +0800 (+08)
Content-Type: multipart/alternative;
 boundary="------------HbSr3gLiwGxtoQlZUHukkkzp"
Message-ID: <9a314838-0b08-4db1-bf73-aedf1389e308@oss.nxp.com>
Date: Thu, 17 Sep 2026 16:45:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/23] NXP DPAA driver enhancements and fixes
To: David Marchand <david.marchand@redhat.com>,
 "stephen@networkplumber.org" <stephen@networkplumber.org>
Cc: "thomas@monjalon.net" <thomas@monjalon.net>, "dev@dpdk.org"
 <dev@dpdk.org>, ci@dpdk.org, Aaron Conole <aconole@redhat.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
References: <20260820144312.3922316-1-hemant.agrawal@nxp.com>
 <20260901101926.1574209-1-hemant.agrawal@nxp.com>
 <GV1PR04MB107502B059AE97F8E6EB7860589BE2@GV1PR04MB10750.eurprd04.prod.outlook.com>
 <CAJFAV8xvV868a4cCK-b-yUVQioqD_tDHZZitsXC+U24A=kZQQQ@mail.gmail.com>
Content-Language: en-US
From: Hemant Agrawal <hemant.agrawal@oss.nxp.com>
In-Reply-To: <CAJFAV8xvV868a4cCK-b-yUVQioqD_tDHZZitsXC+U24A=kZQQQ@mail.gmail.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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

This is a multi-part message in MIME format.
--------------HbSr3gLiwGxtoQlZUHukkkzp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stephen,

On 16/09/2026 15:14, David Marchand wrote:
> On Fri, 11 Sept 2026 at 07:06, Hemant Agrawal<hemant.agrawal@nxp.com> wrote:
>> Hi @David Marchand @stephen@networkplumber.org
>>
>>     My last series could not be applied as it has dependency on 1 patch, which is already in net-next. (but not in main)
>>
>> If I send a new version with :   Depends-on: patch-168711 ("net/dpaa: fix Rx queue shutdown before init")
>>
>> https://git.dpdk.org/next/dpdk-next-net/commit/?id=6109b26794c6c3639e9be8b2a659ba7d8040d4fb
>>
>>
>> Will it work in CI ?
> Afaik, unfortunately, the Depends-on: tag is not implemented in all CI.
> It seems the only good solution is to work and get patches merged in a
> single tree at a time :-(.
>

Will you please push the following patch from dpdk-next-net to dpdk 
main: 
https://git.dpdk.org/next/dpdk-next-net/commit/?id=6109b26794c6c3639e9be8b2a659ba7d8040d4fb

This way our new series of dpaa1 patches will not have apply issue?
https://patches.dpdk.org/project/dpdk/list/?series=39139
--------------HbSr3gLiwGxtoQlZUHukkkzp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Stephen,</p>
    <div class="moz-cite-prefix">On 16/09/2026 15:14, David Marchand
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJFAV8xvV868a4cCK-b-yUVQioqD_tDHZZitsXC+U24A=kZQQQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 11 Sept 2026 at 07:06, Hemant Agrawal <a class="moz-txt-link-rfc2396E" href="mailto:hemant.agrawal@nxp.com">&lt;hemant.agrawal@nxp.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Hi @David Marchand @stephen@networkplumber.org

    My last series could not be applied as it has dependency on 1 patch, which is already in net-next. (but not in main)

If I send a new version with :   Depends-on: patch-168711 ("net/dpaa: fix Rx queue shutdown before init")

<a class="moz-txt-link-freetext" href="https://git.dpdk.org/next/dpdk-next-net/commit/?id=6109b26794c6c3639e9be8b2a659ba7d8040d4fb">https://git.dpdk.org/next/dpdk-next-net/commit/?id=6109b26794c6c3639e9be8b2a659ba7d8040d4fb</a>


Will it work in CI ?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Afaik, unfortunately, the Depends-on: tag is not implemented in all CI.
It seems the only good solution is to work and get patches merged in a
single tree at a time :-(.

</pre>
    </blockquote>
    <div style="font-size: 11pt;"><br data-olk-copy-source="MailCompose">
    </div>
    <div style="font-size: 11pt;">Will you please push the following
      patch from dpdk-next-net to dpdk main:  <span
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);"><a
href="https://git.dpdk.org/next/dpdk-next-net/commit/?id=6109b26794c6c3639e9be8b2a659ba7d8040d4fb"
          class="moz-txt-link-freetext">https://git.dpdk.org/next/dpdk-next-net/commit/?id=6109b26794c6c3639e9be8b2a659ba7d8040d4fb</a></span></div>
    <div style="font-size: 11pt;"><br>
    </div>
    <div
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">This
      way our new series of dpaa1 patches will not have apply issue? </div>
    <div
style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><a
        href="https://patches.dpdk.org/project/dpdk/list/?series=39139"
        class="moz-txt-link-freetext">https://patches.dpdk.org/project/dpdk/list/?series=39139</a></div>
    <blockquote type="cite"
cite="mid:CAJFAV8xvV868a4cCK-b-yUVQioqD_tDHZZitsXC+U24A=kZQQQ@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------HbSr3gLiwGxtoQlZUHukkkzp--
