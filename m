Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39A606A6C0
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Nov 2026 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=CxyBHw21
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CF8B40E01;
	Thu,  5 Nov 2026 20:52:08 +0100 (CET)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTPS id C339C40DD5
 for <dev@dpdk.org>; Thu,  5 Nov 2026 20:52:06 +0100 (CET)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-8b0cf2c0785so20694847b3.3
 for <dev@dpdk.org>; Thu, 05 Nov 2026 11:52:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793908325; cv=none;
 d=google.com; s=arc-20260327;
 b=gg+L9n1g0dxP1O8KMtWGv+a2QIA4t6G4/qZRZzMqZ1TMOcvanUstsG0aWlSc/UjcLM
 76CNQcneR71XwNSDHZQnohvaUKAJvwQ4D9GPYKyqdTvOblvI5ZIiUPSKFimTIVlgkkZn
 n0CL2kQn8y4+pGDYYN+jFFPs96zkCTRcR5vKQX1XuIUaUTfXIOxS55M3j7r/07rJXA4L
 ji4KQNyTWVnGneRm2i451SfStsgyMJCUr7VMsjfLqeE/XYX7Ni4/mUuDMQp25QYJ1GSz
 hgfI25t1kgMMcrKihfuX6d+g7MHpwXcArPyibZ4tjZj1vbPXJC+7p13p5hobc4GJ1zvu
 uotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Jh8hqOZrsHdeTbFfTDBJwGmIHKvDUHcD/Vg2OSkEI1o=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=dAN8wTkX3bzSzuqGhZpWtKlJ3Udv8r9Gh8c3WlNJKz1io7cROhWYl3rpx15hd+SZ1t
 joZ99wyx6PW+3UMeDGxl09VgoBHQZGILMe8SJd8R+bo8Q+Q+hoV8kddegUCL/qdzuExc
 MDFkXsVW52kxjWb8/4eNsGz+NwCj/gYU2uJEYymJBzQST3zJztCLI+kSj4Na+bLUN0U8
 qAcaKQ1YEfRTSVuSG9nwWnKKfC7D9WPxgYITIw7wD/rW9f/D2w2OTt8Uh4LGlGtPjmlq
 ZZeEH5XsFQPDX0YLZ0/R4xLa4OZDwt/Y+mQDJxTzDfKl0ywNd8KNfQu7Iqc8gzCT93/n
 8Wuw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793908325; x=1794513125; darn=dpdk.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Jh8hqOZrsHdeTbFfTDBJwGmIHKvDUHcD/Vg2OSkEI1o=;
 b=CxyBHw21pS02LnGz0gwe1NzTNzodE6q59xhj51ffZV0SJneTYul/Atkbg7bH06hjqG
 miewZd61+HLHWdBJGD0+El6dJSWrCAYRHyeXwhKbvs6/FX26nhgT4dHnc+wQfSRMi5gs
 lVxjvicoKSVbdz2xfxM0QnugDCeayLenJJoeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908325; x=1794513125;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Jh8hqOZrsHdeTbFfTDBJwGmIHKvDUHcD/Vg2OSkEI1o=;
 b=UhL7F+i7eaH2o05OCnYRKMLo5VPIjdxGOv9jZHfFtmWzcHHPrD6/MyZVRQFyBs71yP
 uIoZU+GLwAt1/bJv4vwuyDAtGMjHYcC9FpQ7d+9fyLyHukisD+stmJ2dwVnyauDXT6Kp
 oVfjiU1T9QWgDgUOaXexfZ16fLKx/44LCGHGd3EIZID5CGFEYaGKlMbJggbmPNlKUniv
 7W5xDaeZGtRJoII/LBGbvuQh06X69oeoB2UWkDF7VK9UF+vmypqJWR6XO2hqEK9hXQdj
 LnVWITx2UW7mZsnTqCsaBBH2NOp6qOCX08AMdStkWIF4899jChOaY+JMbGmrqalpMrly
 ZQsQ==
X-Gm-Message-State: APuU4Z+5Ab/rBdi/zZSfc+AXnD3nZ3RowBT9cynfmDT+0OUuOkFkCj6N
 6/ZQlIDCaT0zlOfx9896GxS3A7gnKCY3kvc4lJgodbq2Schdw8F06QcUkQB4cTovfWGHFbSnd0o
 r4ZVmWCw4ON8dwblkcZVLRpnK3XqgVOXtW10/ZnMC+3d+tNej4CfmxZFg8w==
X-Gm-Gg: AYBFou2H5JS1hE869m4JVxVI2N9TCGBw1xrX2BZwcuMIVLa+S8qXtb9O1/6am1IRRS7
 whV+y+CCYRDJuwDfxGbfFtxqm/KbRYyXoNfLGVCp3fFrQ+IWw6st+HYOynYDfbF771DwDp1JGUe
 SUI9Gyjo8De0wROCG4gyLvRHRVAEE9nutqvssDCyO50wofuA5Age3uMTrZHubcyAiyW1UJ7UV8G
 ROTX9EUkdW7zf0ohlo9jMMEot4akz4tSfkNbnGoXBc9zCwc8Afjd/xL45IIczqv9zLEYdQulsgg
 0mgPitkmu/J/zmyIjLQlDEQBGGihWL2uilbxJOcGplwlaTapY2Tx2Plpv7qptam0PbPFc/tYZGx
 rX0s16iPFL3/PeXw/fEHfw5zAHPZKKY71b0DSkJyTp/dbfiX9/4TIw4Tqu7JlvD1rw384Nt0=
X-Received: by 2002:a05:690c:386:b0:8b1:55f4:eb4f with SMTP id
 00721157ae682-8b3419b32eemr184167b3.71.1793908325293; Thu, 05 Nov 2026
 11:52:05 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dillon Ladd <dladd@iol.unh.edu>
Date: Thu, 5 Nov 2026 14:51:29 -0500
X-Gm-Features: AclHuK_zhTR9yzpi-HvSDIoWx4lo8RZJWmmrSfwZjBwUftMwWrKbsx7jxXDMWAU
Message-ID: <CAJA6v3ybgpA5nx9R9+V+M-6C_f4CUPkCQk4n4m=1Cdowu6qKtw@mail.gmail.com>
Subject: November 5th, 2026 DTS Working Group Meeting Notes
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000007d3f1d065f8cd414"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000007d3f1d065f8cd414
Content-Type: text/plain; charset="UTF-8"

Attendees
################################################
Dillon Ladd, UNH-IOL
Koushik Bhargav Nimoji, UNH-IOL
Andrew Bailey, UNH-IOL
Luca Vizzarro

General Discussions
==============================================
None

Patch Discussions
==============================================
Andrew put together a list of patches ranked by priority for review:

High priority
----------------------------------------------------
* dts: refactor cryptodev test suites: - NEW VERSION IN PROGRESS
https://patchwork.dpdk.org/project/dpdk/list/?series=39719
* Pvp multi paths vhost/virtio performance test suites: - NEW VERSION IN
PROGRESS https://patchwork.dpdk.org/project/dpdk/list/?series=39746
* Add ipgre test suite:
https://patchwork.dpdk.org/project/dpdk/list/?series=39718
* dts: restore unbinded ports to initial state:
https://patchwork.dpdk.org/project/dpdk/list/?series=39444
* dts: update configuration for performance test:
https://patchwork.dpdk.org/project/dpdk/list/?series=39817

Medium priority
----------------------------------------------------
* dts: add PVVP case to virtio suite:
https://patchwork.dpdk.org/project/dpdk/list/?series=38927
* dts: refactor flow suite with generator pattern:
https://patchwork.dpdk.org/project/dpdk/list/?series=38926
 * dts: update verbose output regex for VXLAN packets
https://patchwork.dpdk.org/project/dpdk/list/?series=38925 (edited)

Luca noted that as many patches as possible should be merged before Monday,
as only bug fixes should be merged after then.

26.11 DTS Roadmap
==============================================
* Finalized roadmap for 26.11 is out:
https://mails.dpdk.org/archives/dev/2026-September/345096.html
* Last 26.11 items: EventDev update
To be internally reviewed by UNH today, and hopefully out by EoD.
* 2027 DTS work finalized:
 Extend DTS test coverage: more ethdev features such as: Flow Control, TCP
Segmentation Offload, IEEE 1588 Timestamping
Write skills files for AI writing of DTS code
Extend the prototyped AI Tool for agentic DTS development
Extend DTS test coverage: L3 Forwarding
Extend DTS test coverage: EventDev (functional test)

Any other business
==============================================
Next Meeting: November 19th, 2026


-- 
Dillon Ladd
Technical Manager, Open Source
UNH Interoperability Lab
21 Madbury Rd., Ste. 100, Durham, NH 03824
dladd@iol.unh.edu
https://www.iol.unh.edu

--0000000000007d3f1d065f8cd414
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Attendees<br>###################################=
#############<br>Dillon Ladd, UNH-IOL<br>Koushik Bhargav Nimoji, UNH-IOL<br=
>Andrew Bailey, UNH-IOL<br>Luca Vizzarro</div><div><br>General Discussions<=
br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>None<=
br><br>Patch Discussions<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Andrew put together a list of patches ranked by prior=
ity for review:</div><div><br></div><div>High priority<br>-----------------=
-----------------------------------<br>* dts: refactor cryptodev test suite=
s: - NEW VERSION IN PROGRESS =C2=A0<a href=3D"https://patchwork.dpdk.org/pr=
oject/dpdk/list/?series=3D39719">https://patchwork.dpdk.org/project/dpdk/li=
st/?series=3D39719</a><br>* Pvp multi paths vhost/virtio performance test s=
uites: - NEW VERSION IN PROGRESS <a href=3D"https://patchwork.dpdk.org/proj=
ect/dpdk/list/?series=3D39746">https://patchwork.dpdk.org/project/dpdk/list=
/?series=3D39746</a><br>* Add ipgre test suite: <a href=3D"https://patchwor=
k.dpdk.org/project/dpdk/list/?series=3D39718">https://patchwork.dpdk.org/pr=
oject/dpdk/list/?series=3D39718</a><br>* dts: restore unbinded ports to ini=
tial state: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D39444">https://patchwork.dpdk.org/project/dpdk/list/?series=3D39444</a><=
br>* dts: update configuration for performance test: <a href=3D"https://pat=
chwork.dpdk.org/project/dpdk/list/?series=3D39817">https://patchwork.dpdk.o=
rg/project/dpdk/list/?series=3D39817</a></div><div><br>Medium priority</div=
><div>----------------------------------------------------<br>* dts: add PV=
VP case to virtio suite: <a href=3D"https://patchwork.dpdk.org/project/dpdk=
/list/?series=3D38927">https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D38927</a><br>* dts: refactor flow suite with generator pattern: <a href=
=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D38926">https://p=
atchwork.dpdk.org/project/dpdk/list/?series=3D38926</a><br>=C2=A0* dts: upd=
ate verbose output regex for VXLAN packets <a href=3D"https://patchwork.dpd=
k.org/project/dpdk/list/?series=3D38925">https://patchwork.dpdk.org/project=
/dpdk/list/?series=3D38925</a> (edited) <br><br>Luca noted that as many pat=
ches as possible should be merged before Monday, as only bug fixes should b=
e merged after then. <br><br></div><div>26.11 <span class=3D"gmail-il">DTS<=
/span> Roadmap<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</div><div>* Finalized roadmap for 26.11 is out: <a href=3D"https://m=
ails.dpdk.org/archives/dev/2026-September/345096.html">https://mails.dpdk.o=
rg/archives/dev/2026-September/345096.html</a><br>* Last 26.11 items: Event=
Dev update<br>To be internally reviewed by UNH today, and hopefully out by =
EoD. <br>* 2027 DTS work finalized:=C2=A0<br>=C2=A0Extend DTS test coverage=
: more ethdev features such as: Flow Control, TCP Segmentation Offload, IEE=
E 1588 Timestamping <br>Write skills files for AI writing of DTS code <br>E=
xtend the prototyped AI Tool for agentic DTS development <br>Extend DTS tes=
t coverage: L3 Forwarding <br>Extend DTS test coverage: EventDev (functiona=
l test)=C2=A0<br></div><div><br></div><div>Any other business<br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><font color=3D"=
#888888"></font><div>Next Meeting: November 19th, 2026<font color=3D"#88888=
8"><br></font><br class=3D"gmail-Apple-interchange-newline"></div></div><di=
v><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=
=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr">Dillon Ladd<div>Technical Manager, Open Source<br><font color=
=3D"#000000">UNH Interoperability Lab</font></div>21 Madbury Rd., Ste. 100,=
 Durham, NH 03824<div><a href=3D"mailto:dladd@iol.unh.edu" target=3D"_blank=
">dladd@iol.unh.edu</a></div><div><a href=3D"https://www.iol.unh.edu/" styl=
e=3D"color:rgb(17,85,204)" target=3D"_blank">https://www.iol.unh.edu</a></d=
iv><div><img src=3D"https://www.iol.unh.edu/sites/all/themes/custom/iol2013=
/img/logo.png" width=3D"200" height=3D"52"><br></div></div></div></div>

--0000000000007d3f1d065f8cd414--
