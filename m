Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B6606A323
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=monjalon.net header.i=@monjalon.net header.a=rsa-sha256 header.s=fm3 header.b=Lwnza1QH;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4AsaHew3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7059A4060C;
	Thu, 26 Nov 2026 16:18:04 +0100 (CET)
Received: from mails.dpdk.org (localhost [127.0.0.1])
 by mails.dpdk.org (Postfix) with ESMTP id D0006402C9;
 Thu, 26 Nov 2026 16:18:02 +0100 (CET)
Received: from fout-b8-smtp.messagingengine.com
 (fout-b8-smtp.messagingengine.com [202.12.124.151])
 by mails.dpdk.org (Postfix) with ESMTPS id 15D31402BD
 for <announce@dpdk.org>; Thu, 26 Nov 2026 16:18:01 +0100 (CET)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 043621D00162
 for <announce@dpdk.org>; Thu, 26 Nov 2026 10:17:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 26 Nov 2026 10:18:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to; s=fm3; t=1795706279; x=1795792679; bh=f82M9LfZU7
 k+CEd23dDekNZEEkudNMOM2tiDgu4bRWU=; b=Lwnza1QHK6Lm1IacD+pdTwmOhK
 OQKyeL6RfZADhEAI4EJ6f4Voq5wul41aoBALGbna298nA0y2ti2Ej+va6AiMHE4E
 Hsbn3F8RvssGkDGWE51QHA41rwYfeY9Mhqb3i7iJJE4Q4BuleGEy2Vm2Sd8QbdRy
 6EGHoPJytg74VY7pdJeChfF1cvuMBnu4WQlgrPP41u8IidxVdRcHEUAbiiYTA2xA
 nM26k1YBsTP9/vF6XRyYev17Ik5smPW+Xr4A9E4SieBKef1Cb9XxhqFo7VW5CcQ+
 1Iop806Z/BgXcMdGG36zLUF8Ghqh7shwa/U86vmUqJdKseuP1c/zp7cA5KEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1795706279; x=1795792679; bh=f82M9LfZU7k+CEd23dDekNZEEkudNMOM2ti
 Dgu4bRWU=; b=4AsaHew3ze7KsyOoesrvCJ2dHzoXvJqyt3G1UnRw6XGd87Edi4j
 bPk5NHytYro+x+n6QMyjJD3PnkMBcC/rPeOeCZMD6VX+lQ0h5MmEUS7WVoIYrXH2
 zwprEaYzzvXx4uzdNEZknXQ2MGJKI3EhCjCAu8eVD23/Rn/DOuNVSiLs/KomCOb8
 OQGd37y/SM4ds/9/YLeNejxko7HHlaNHq+vd6lNEnZDk1Ezg4ImEpeSczOJ2O2cm
 vuMoX5I8CVPLmsO3XdK1FdURfCnHrF4DItFDp/KLUaNj38ON44oG7ctJgF5QgyrW
 xtS3iKqiW9aM+3G+BGeBzA1Xa7KSz9sLA2Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=monjalon.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795706279; d=monjalon.net;
 mf=PHRob21hc0Btb25qYWxvbi5uZXQ+;
 rt=PGFubm91bmNlQGRwZGsub3JnPg==;
 s=fm3:rsa-sha256:SqB9pO79Uv7IX7/bFGvGl6WPZUVDGd/4LE1b2zsQ3YXgJ49
 DB1H/9vtzR4reedCAcbzONynn3VgwldH2YshglJVwKgW8whja+q/ZIetljyCLv1/
 fD2/5suoN7NFTsj9z7AgmnQTOJdBmfax4bTOZfGS33a9hzdvtgT0WsNosQJQPVVd
 sS8dhpyIfnJ+aLzZGycRqGYP1IFWO73mXHkgUwXmKF5WaZ1efPj75HZuY32krbn4
 BkdZfdqojSAvGWdeneyEanTsEGdmiqGlitTe+i9Rj6031RmLP5YV3j0u4CVl6Oi3
 Sm6fArsn6hTY4YG5pbyjYKDn6X24CASJ80hy+Ug==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=9;
 hn=content-transfer-encoding,content-type,date,feedback-id,from,
 message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:KKdB1rM0DRG20+AANz2y5/G/8UuNI7MIBQ4k9kGuKoE=:rLLKXJjLnYxCMnldCGwGaZ42rhPaQsW1yDFLs1vkuhA=;
X-ME-Sender: <xms:p00Ia5llIWrkwdlHKagi0zxqwb8RVRTrRZW0kCNvQSF3z-89nSNeSg>
 <xme:p00Ia6tJKfv4X-WGqM5ZbwiRLPuLW8aMASw3MAD1YBd-eD1sDUgcRuwEXYYdk55rP
 J6h1AbYg-xOx4_-bjZnQjhiTHRwAl5_rBmfsAf-G5JnyvC-VWZ3NMcz>
X-ME-Received: <xmr:p00Ia6vMGEUe7wAoztVgkaXvl2CKIMRjN-YvIxeUujYgrX6Czhc5yrUnPcGhmY3ctVAShOynHJAESUGLg9hh7uE>
X-ME-Proxy-Cause: dmFkZTEOZhr76h7MnGImS888vJpgA8QoUrJz0D8oLH+ciI4xawaeTH8g08gQYDuh5JBeNN
 eytHF5QaN0SmFx2COOi5qlmdTxUwfGrFTlZLRvIELY3ebAd9o0s4MDq/KH1CD8/bm6B4mP
 Ca7bdiF8Ff3xqsRpRWzHql5S8njLxS5pzll+yxWBaYmi0DG4Ac9K9/CUTNsvOX3RNbLiSm
 urz6uuCaCzvFs/HsmM+AkaETomWuombiipSekXv81Th6dDLxPrzri3ttWXyBbxbvCqcMtz
 tHy3EJuZwlzPb/AWxhWN/1DLoaYMVfv0d0HK426oHWnLb9qGnw2uq2hMIg6SDQ0PhOyDd9
 bp+YRcQsy6MF2BdtV+InIlmvCFw0MpabKEBG067mS32aH7H75/D3LC862hlfjp6M5qQhqs
 yMVTPkmtvM90O398yWf9e5I7nRZuBAQT/kOcUKiYYFdbjSo2eCbkfndUELGLe7+12LFqSg
 L+0SMXgwPD6TJGrtW4up3pJ7T+6P+sO4TuRnG37Vq0pZnja+k/IByXshB5SC3KuhgxWXt7
 4CAKB8z/Zcia0Unv61FTwwlbRgD4+RVNoEnBgk5kEiLgfsZZV9SZOesmtg07oAmMBJacOU
 gv33AtUdcn0D/EBHSYYkhdlNd6KW7zznvWl9F58nyH+tEDbm1/GuB7q3E8mw
X-ME-Proxy: <xmx:p00Ia2bbtFHLJj-8zSCnWwuf7PgSF5OEvYZ2Sz_ehdC5N-HXAX7aUg>
 <xmx:p00Ia7Z5SXke6B5xhciku5KbbWcYY3jEnqyFdrv_8Lv9XMQbtYYCeQ>
 <xmx:p00Ia6XX3xcbzjHsD7BpGF1KNCvY3NciAGCH-RdxMcHan__WO2mZoQ>
 <xmx:p00Ia60ETsle0ETKlF2AzTsWK8G9iHvNDW2lqoB400AOGdIEQZblyw>
 <xmx:p00Ia8kKN0AyELWrXd5gFn1rUdrW0C6v-RGzxMkSR-wpzRXWpin9-fkq>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <announce@dpdk.org>; Thu, 26 Nov 2026 10:17:59 -0500 (EST)
From: Thomas Monjalon <thomas@monjalon.net>
To: announce@dpdk.org
Subject: DPDK 26.11 released
Date: Thu, 26 Nov 2026 16:17:57 +0100
Message-ID: <jHjL_3-mTEabglXIS0cxPg@monjalon.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: announce@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
X-BeenThere: dev@dpdk.org
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A new major release is available:
	https://fast.dpdk.org/rel/dpdk-26.11.tar.xz

Yes, 26.11 was released on 26-11-26!

It is a good November release:
	1268 commits from 156 authors
	1622 files changed, 90294 insertions(+), 94935 deletions(-)

This release breaks API/ABI compatibility with previous releases,
as detailed in the release notes.
The new major ABI version is 27.
The 27.03 and 27.07 releases will be ABI-compatible with 26.11.

The 26.11 branch is expected to be supported for three years
and is recommended for system integration and deployment.

Highlights of 26.11:
	- pile stack-like container and mempool driver
	- interrupt FD leak detection
	- VFIO API made internal
	- VFIO character device
	- Device Tree matching in platform bus
	- 1.6 Tb/s as new maximum link speed
	- module EEPROM decoding
	- flow graph parser for drivers
	- RSA capability parameters
	- AMD NTB and AE4DMA drivers
	- NXP i.MX95 eDMA5 driver
	- baseband statistics per queue
	- auto-detection of uncore power driver
	- graph profiling
	- eBPF validation tool
	- Wycheproof crypto validation tool
	- removal of deprecated API

More details in the release notes:
	https://doc.dpdk.org/guides/rel_notes/release_26_11.html


There are 52 new contributors (including authors, reviewers and testers).
Welcome to Aleksandr Khromov, Alexander Goodkind, Alexandru-Ionut Jipa,
Andrei-Niculae Petre, Andrey Mokrushin, Andrey Yudin, Artem Novikov,
Arthur Chan, Artin Davari, Chen Zhao, Cosmin Ratiu, Dillon Ladd,
Dmitriy Matveichev, Dragos Tarcatu, Evgeny Sokolov, Frank Dressler,
Guillaume Gardet, Ivar Al-Safawi, Jerome Tollet, Jia Jia, Joey Zhong,
Joseph Wong, Kevin Bowling, Kobi Kenzi, Mark Bulatov, Matthew G. McGovern,
Mikhail Mamatov, Mohit Kumar Parjapat, Naseeb Dangi, Omar Munchaev,
Orgad Shaneh, Peng Peng, Randy L Tice, Randy Tice, Rita Ruvinsky,
Rob Peters, Roman Khromenok, Ryan Wolfe, Samar Yadav, Sebti Mouelhi,
Shrey Khandelwal, Shuaisong Yang, Sid Ali Cherrati, Stephen Haruna,
Su Sai, Wei Chen, Wei Yan, William Bland, Yang Xiaoliang,
Yashaswini Kanaujia, Yashaswini Raghuram Prathivadi Bhayankaram,
and Yonghao Li.

Below are the top commit counts per employer (with authors count):
	331     Intel (30)
	178     stephen@networkplumber.org (1)
	123     Red Hat (5)
	 78     Marvell (19)
	 68     NXP (5)
	 63     Broadcom (13)
	 52     NVIDIA (9)
	 48     LinkData (1)
	 39     AMD (2)
	 26     Huawei (3)
	 25     UNH (3)
	 19     Google (4)
	 17     WangXun (1)
	 16     SmartShare Systems (1)
	 14     zhtfdev@gmail.com (1)
	 14     T-Argos (1)
	 14     Ark Networks (1)
	 12     VMware (1)
	 12     Ericsson (2)
	        ...

A big thank you to everyone who took on the often thankless task
of reviewing other people's work.
Based on Reviewed-by and Acked-by tags, the top non-PMD reviewers are:
     44     Bruce Richardson <bruce.richardson@intel.com>
     29     Konstantin Ananyev <konstantin.ananyev@huawei.com>
     23     Maxime Coquelin <maxime.coquelin@redhat.com>
     15     David Marchand <david.marchand@redhat.com>
     14     Morten Br=C3=B8rup <mb@smartsharesystems.com>
     14     Marat Khalili <marat.khalili@huawei.com>
     13     Stephen Hemminger <stephen@networkplumber.org>
     11     Chengwen Feng <fengchengwen@huawei.com>


The next version will be 27.03 in March.
New feature proposals must be submitted by Christmas
so we can have -rc1 ready before Chinese New Year:
	http://core.dpdk.org/roadmap#dates

Enjoy the rest of the year!

Thanks everyone


