Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAE3606A31F
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=HnHg5dEk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2DB140264;
	Thu, 22 Oct 2026 21:40:40 +0200 (CEST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com
 [209.85.128.175])
 by mails.dpdk.org (Postfix) with ESMTP id 7B6E44003C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 21:40:39 +0200 (CEST)
Received: by mail-yw1-f175.google.com with SMTP id
 00721157ae682-8ac9d666d4eso2063067b3.3
 for <dev@dpdk.org>; Thu, 22 Oct 2026 12:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792698039; cv=none;
 d=google.com; s=arc-20260327;
 b=bU8hycjT58oip/zVsSytO6M9xOqSHuUAgw1eRmVUoybWfA1la+vazYNlci4p9koTtl
 PQavsOzzCZVzD8QLZEcwlt73uN+CjKiAR2XqMOYlGx7fJ8DlVJMDB+6gVcbsiU20KkLv
 hid6GErs3qnlyP7IhKE+U1KvFuU7R9ae01vDJbEtwRn6FqqtZM8LHA4MNMz5gQVc393W
 rw4fkx55oa0E+6RJ3/sEu7wEwYpVqL+RluXYwytwHqwHuKw4WEDJxKNeroTZ1iyb/GuU
 JaPYfBqlW6SYeU2YlP3v/84pDNjzEZ3BpGFxIXPnDHZTpOscVM2HANyWjoaqTvH0bWHy
 18iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=39d00c2ji8sQatt5ynoJN4xaH6fzywC1VfNJ8Rpjv34=;
 fh=eUqWHLlhrxpykrabbQYbmT5B5FclN6p18glcXqrZikU=;
 b=SQdrl9j9LgEU6ozrowzEplGmtdfZeEJfooynT4FUlyi2xNeuUG4GwLPcPEOJ1qhoPY
 701aM1JU6B1/2C+ITSR3xKznQvJdzCqSj9rYlsTogJN45K+k0Tt9o8ueImMtQSxZQJat
 bqoY5zs7KvB5yXzolmJO9M/3nSAIK4FYTh+CFKMAwCJFlo6HZalEX4H5TmalYA3zg+Tw
 dhMfcHPpTgk6fd8uDf4uY5BLWs6sZeAf+5mg5353Tri5whTstCkGanwMlztHTuY+712+
 hBSIcech8lBKeWoJmJzWqozkMmyGgRAtiw6XKULGvZn5If5V+yUfuPtccUNIDH6wKnff
 TwZA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1792698039; x=1793302839; darn=dpdk.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=39d00c2ji8sQatt5ynoJN4xaH6fzywC1VfNJ8Rpjv34=;
 b=HnHg5dEkXOiCcwo1B+sRT3e8Cqm0Fbwcw4INOjSUN1HhGJvMlGKx8/dKNBsky+C7BL
 cbOwOuF6HSkyTGFQKTz1Ugu5rORw/Zzo+j/sLFMRqN86Nl36uO4onPMecFdZhaGSJhpd
 cBOU7JEo+QPj0rmU5ZPuOsOHIN8YoHv4YkkY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792698039; x=1793302839;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=39d00c2ji8sQatt5ynoJN4xaH6fzywC1VfNJ8Rpjv34=;
 b=n/9mCVZczwBba3ApclxAmpvrBznkoX4DK8dW7ANu0ncPb4oklfrlpVgBNqLvQLL0ya
 v/7/ySve/Yq/lfNsBOOSMFSbNZvkR6GaAKE34LsXeTkji/c1gJ2gWA/49piJ/3oAPlor
 5P9s9ViSqrUSCGpSVbCpCH/Y5MBFrGn1392abnwq7EowFYfEtEEJc7BLVrr1Xk9zBqVw
 bcaGulM/W8pkRmatpiqMCuA7SWy7r+uCdbVof6RmbHzuKpjCTLscXpMDJJFzNNi3Sx5T
 yLnjJIyym5u7twWooYNX8sQsCN6NczlE8XcIO2sPe2VNJDpLLAj/bDXKUefH434GXRcs
 0EHA==
X-Gm-Message-State: AFq9FYILdMbO5x8M0BmxlV2gklKmpgfbZmnltH2xcFcwVFeHaAXh3olh
 FoofbV/pmRywCaO6IjCBXavHeZg73ImNd445hXusJ4kTkBAeKceSum5hvSpbqdOiSin/T0TIhZL
 oBR/3BDjPqkc/gmEl5kDjlxBF4B4H5RLr2rlc2yxFDEUhE7smjso2oZs5Zw==
X-Gm-Gg: AYBFou12gGOzrral6WyLDL9DWQJBSMEog1sInLiyYV+QOdQz/LHdidiVGxuB2VG0JCa
 hdr0LJZQlaYn7lK41tAGQSpI18q8S6LLPupKiAh7llJkXpu0BTzSgUsb2oXZU2nYVIK3e8Y0vWo
 sUDxY1V1J+wegmXWUFWGjp1oLwDz/tXLHkLWj0bV9t0avy6JF8txWJDN0zql+Md3jq6t99R51uD
 dA5GIP+JGpQwfvP5pC1CQJfAfoiXLz9byYHP6mkn8XjZsELTQFpQ8VqMFFb+5y0pi6cRwtnS+85
 BhgIrQWsTJRuhD1ZyGA6W5+gkSDXIXGJcWFcrI9Gjj+G9TI4J+85rYwFH5NJpMsJWBkP3WD2zA0
 0O2pTwuCBUnT5rewQgm5KL+y6ceVjQW7Ckt5Yh5hUy+7D2/bJX7xPbZuF9aMx+Zk737I57cs=
X-Received: by 2002:a05:690c:c512:b0:89a:63bc:8dd with SMTP id
 00721157ae682-8b157eb32f1mr96037b3.103.1792698038618; Thu, 22 Oct 2026
 12:40:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Dillon Ladd <dladd@iol.unh.edu>
Date: Thu, 22 Oct 2026 15:40:01 -0400
X-Gm-Features: AclHuK-HtORG1-Nk_Pm-ixkh0k3oQ43xzBiVaqo3UYsnr4PilnACJrB5_8R-MVw
Message-ID: <CAJA6v3w0MtNsVNazB5-fhdPweeFLZ25AQ7tQCr8JcpU8kk9r=A@mail.gmail.com>
Subject: October 22nd, 2026 DTS Working Group Meeting Notes
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c81ccb065e7309c4"
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

--000000000000c81ccb065e7309c4
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

DTS Framework:
--------------------------------------------------------------------------------
New Suites:[RFC] dts: resolve trex driver binding issue
https://patches.dpdk.org/project/dpdk/patch/20260811185509.1650102-1-knimoji@iol.unh.edu/
Koushik needs to make adjustments.
Specify version changes explicitly.

New Suites
--------------------------------------------------------------------------------
[v3,1/3] dts: add directory for test resources
https://patches.dpdk.org/project/dpdk/list/?series=39721
Pending Review
[v2] dts: add pvp multi paths vhost performance testsuite
https://patches.dpdk.org/project/dpdk/patch/20261020173029.162255-1-knimoji@iol.unh.edu/
Pending Review
[v1] dts: add pvp multi paths virtio performance testsuite
https://patches.dpdk.org/project/dpdk/patch/20261020173029.162255-2-knimoji@iol.unh.edu/
Pending Review
[v3] dts: add ipgre test suite
https://patches.dpdk.org/project/dpdk/patch/20261019194841.890257-1-abailey@iol.unh.edu/
Pending review

Test Suite Extensions:
--------------------------------------------------------------------------------
[v1] dts: refactor cryptodev throughput test suite
https://patches.dpdk.org/project/dpdk/patch/20261019200424.898640-1-abailey@iol.unh.edu/
Pending Review
[v1] dts: update configuration for performance test
https://patchwork.dpdk.org/project/dpdk/patch/20260805153658.345207-1-abailey@iol.unh.edu/
Pending review
[v1] dts: add PVVP case to virtio suite
https://patches.dpdk.org/project/dpdk/patch/20260811171235.519323-1-abailey@iol.unh.edu/
Pending Review
[v7] dts: refactor flow suite with generator pattern
https://patches.dpdk.org/project/dpdk/patch/20260811170433.517663-1-abailey@iol.unh.edu/
Pending Review


Bug fixes:
--------------------------------------------------------------------------------
[RFC] dts: restore unbinded ports to initial state
https://patches.dpdk.org/project/dpdk/patch/20260929134920.330389-1-knimoji@iol.unh.edu/
Pending Review
[v1] dts: remove crypto test type
https://patches.dpdk.org/project/dpdk/patch/20261019201342.903235-1-abailey@iol.unh.edu/
Pending Review
dts: update verbose output regex for VXLAN packets
https://patches.dpdk.org/project/dpdk/list/?series=38925
Pending Review

26.11 DTS Roadmap
==============================================
Finalized roadmap for 26.11 is out:
https://mails.dpdk.org/archives/dev/2026-September/345096.html
We are done with all items on the 26.11 roadmap except the EventDev test
suite port from old-dts.
Looking at possible work items for 2027
Tech board showed most interest in:
Finding gaps in ethdev coverage
We found that there is little coverage for flow control and TCP
Segmentation offload
AI Skills files
Moderate interest in adding testing support for L3 Forwarding.

Any other business
==============================================
Next Meeting: November 5th, 2026

-- 
Dillon Ladd
Technical Manager, Open Source
UNH Interoperability Lab
21 Madbury Rd., Ste. 100, Durham, NH 03824
dladd@iol.unh.edu
https://www.iol.unh.edu

--000000000000c81ccb065e7309c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div>Attendees<br>#########################=
#######################<br>Dillon Ladd, UNH-IOL<br>Koushik Bhargav Nimoji, =
UNH-IOL<br>Andrew Bailey, UNH-IOL<br>Luca Vizzarro</div><div><br>General Di=
scussions<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D<br>None<br><br>Patch Discussions<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Andrew put together a list of patches ran=
ked by priority for review:<br><br>DTS Framework:<br>----------------------=
----------------------------------------------------------</div><div><span =
style=3D"background-color:transparent">New Suites:[RFC] dts: resolve trex d=
river binding issue</span></div><div><a href=3D"https://patches.dpdk.org/pr=
oject/dpdk/patch/20260811185509.1650102-1-knimoji@iol.unh.edu/">https://pat=
ches.dpdk.org/project/dpdk/patch/20260811185509.1650102-1-knimoji@iol.unh.e=
du/</a><br>Koushik needs to make adjustments. <br>Specify version changes e=
xplicitly. <br><br>New Suites<br>------------------------------------------=
--------------------------------------<br>[v3,1/3] dts: add directory for t=
est resources<br><a href=3D"https://patches.dpdk.org/project/dpdk/list/?ser=
ies=3D39721">https://patches.dpdk.org/project/dpdk/list/?series=3D39721</a>=
<br>Pending Review <br>[v2] dts: add pvp multi paths vhost performance test=
suite<br><a href=3D"https://patches.dpdk.org/project/dpdk/patch/20261020173=
029.162255-1-knimoji@iol.unh.edu/">https://patches.dpdk.org/project/dpdk/pa=
tch/20261020173029.162255-1-knimoji@iol.unh.edu/</a><br>Pending Review<br>[=
v1] dts: add pvp multi paths virtio performance testsuite<br><a href=3D"htt=
ps://patches.dpdk.org/project/dpdk/patch/20261020173029.162255-2-knimoji@io=
l.unh.edu/">https://patches.dpdk.org/project/dpdk/patch/20261020173029.1622=
55-2-knimoji@iol.unh.edu/</a><br>Pending Review<br>[v3] dts: add ipgre test=
 suite<br><a href=3D"https://patches.dpdk.org/project/dpdk/patch/2026101919=
4841.890257-1-abailey@iol.unh.edu/">https://patches.dpdk.org/project/dpdk/p=
atch/20261019194841.890257-1-abailey@iol.unh.edu/</a> <br>Pending review</d=
iv><div>=C2=A0<br></div><div>Test Suite Extensions:<br>--------------------=
------------------------------------------------------------</div><div>[v1]=
 dts: refactor cryptodev throughput test suite<br><a href=3D"https://patche=
s.dpdk.org/project/dpdk/patch/20261019200424.898640-1-abailey@iol.unh.edu/"=
>https://patches.dpdk.org/project/dpdk/patch/20261019200424.898640-1-abaile=
y@iol.unh.edu/</a><br>Pending Review <br>[v1] dts: update configuration for=
 performance test<br><a href=3D"https://patchwork.dpdk.org/project/dpdk/pat=
ch/20260805153658.345207-1-abailey@iol.unh.edu/">https://patchwork.dpdk.org=
/project/dpdk/patch/20260805153658.345207-1-abailey@iol.unh.edu/</a> <br>Pe=
nding review<br>[v1] dts: add PVVP case to virtio suite<br><a href=3D"https=
://patches.dpdk.org/project/dpdk/patch/20260811171235.519323-1-abailey@iol.=
unh.edu/">https://patches.dpdk.org/project/dpdk/patch/20260811171235.519323=
-1-abailey@iol.unh.edu/</a><br>Pending Review<br>[v7] dts: refactor flow su=
ite with generator pattern<br><a href=3D"https://patches.dpdk.org/project/d=
pdk/patch/20260811170433.517663-1-abailey@iol.unh.edu/">https://patches.dpd=
k.org/project/dpdk/patch/20260811170433.517663-1-abailey@iol.unh.edu/</a><b=
r>Pending Review</div><div><br></div><div>=C2=A0<br></div><div>Bug fixes:<b=
r>-------------------------------------------------------------------------=
-------</div><div>[RFC] dts: restore unbinded ports to initial state<br><a =
href=3D"https://patches.dpdk.org/project/dpdk/patch/20260929134920.330389-1=
-knimoji@iol.unh.edu/">https://patches.dpdk.org/project/dpdk/patch/20260929=
134920.330389-1-knimoji@iol.unh.edu/</a><br>Pending Review <br>[v1] dts: re=
move crypto test type<br><a href=3D"https://patches.dpdk.org/project/dpdk/p=
atch/20261019201342.903235-1-abailey@iol.unh.edu/">https://patches.dpdk.org=
/project/dpdk/patch/20261019201342.903235-1-abailey@iol.unh.edu/</a><br>Pen=
ding Review<br>dts: update verbose output regex for VXLAN packets<br><a hre=
f=3D"https://patches.dpdk.org/project/dpdk/list/?series=3D38925">https://pa=
tches.dpdk.org/project/dpdk/list/?series=3D38925</a><br>Pending Review<br><=
/div><div><br></div><div>26.11 DTS Roadmap<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>Finalized roadmap for 26.11 =
is out: <a href=3D"https://mails.dpdk.org/archives/dev/2026-September/34509=
6.html">https://mails.dpdk.org/archives/dev/2026-September/345096.html</a><=
br>We are done with all items on the 26.11 roadmap except the EventDev test=
 suite port from old-dts.<br>Looking at possible work items for 2027<br>Tec=
h board showed most interest in: <br>Finding gaps in ethdev coverage<br>We =
found that there is little coverage for flow control and TCP Segmentation o=
ffload<br>AI Skills files <br>Moderate interest in adding testing support f=
or L3 Forwarding.=C2=A0<br></div><div><br></div><div>Any other business<br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div>N=
ext Meeting: November 5th, 2026</div><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature" da=
ta-smartmail=3D"gmail_signature"><div dir=3D"ltr">Dillon Ladd<div>Technical=
 Manager, Open Source<br><font color=3D"#000000">UNH Interoperability Lab</=
font></div>21 Madbury Rd., Ste. 100, Durham, NH 03824<div><a href=3D"mailto=
:dladd@iol.unh.edu" target=3D"_blank">dladd@iol.unh.edu</a></div><div><a hr=
ef=3D"https://www.iol.unh.edu/" style=3D"color:rgb(17,85,204)" target=3D"_b=
lank">https://www.iol.unh.edu</a></div><div><img src=3D"https://www.iol.unh=
.edu/sites/all/themes/custom/iol2013/img/logo.png" width=3D"200" height=3D"=
52"><br></div></div></div></div>

--000000000000c81ccb065e7309c4--
