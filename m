Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC95606A326
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iol.unh.edu header.i=@iol.unh.edu header.a=rsa-sha256 header.s=unh-iol header.b=Y6ZD4Wsi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D74D42DDF;
	Tue,  3 Nov 2026 16:37:45 +0100 (CET)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 0514A40265
 for <dev@dpdk.org>; Tue,  3 Nov 2026 16:37:44 +0100 (CET)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-70b875f6f1fso3985366eaf.2
 for <dev@dpdk.org>; Tue, 03 Nov 2026 07:37:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793720263; cv=none;
 d=google.com; s=arc-20260327;
 b=GK6IqcSO4jSvQa2ce3CoQCanMLFzhaKIfQc9JrB6Hf4hnovh152y92iWyaQZTPrU1m
 /ajghlZytWpOfVPAzqjsNt/zqI9QY4HhnGyKipKNS0NLDinCSUufbZ+fkpUzlHx1vu5C
 Ov7q8+nPLAh56Z5+K7f26MBxj4125rxAIlWG4sw+zfjToioT0LvMbnCQER+SMaVnjw+g
 G7Bdvwkla10Brqujpr+VD8rMqLoNIcfd1wAHmnteDx9XfMCzbUr8slxJGd+6qdNrSK9I
 uefGVoTO4fkUr/qiZ7DXeHHGj/SI2BqKxPxghBGk0DRJb0rTtk5il+tELOv8gqJeHYo+
 1jiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=H8lacteXxIpEXxT0WyruqaRka3glnGmTDLip0Kh6bxY=;
 fh=FCGCaq8HJdvV0/Rzf93Q72GjTtlfixYcxtzuhqoU8PM=;
 b=icGfHYoJMUYHimtjSS03s9+TlrEYzH8eqIUZ2saQHWaQwd1tyaQgEl7Qfa/eCurPpu
 mbWZbNssjVk7xnVMLLVKI4GkLoPAQERTfpCRbzcT75nFZ6Jg5sD+u4KLnziRm1Q0S+Mp
 xCxNYdyZsxk5ZZgd7Pek4rXvfyzGKzyYZ9QStQFToOM/s+4jrhTq/q03ZuzEgHhUYb4n
 HFUsSy8+vxhCBuQyA9KKxVhiw3R59KTEk2s5Y6twQMQ5nYV8P9kAr7dUi235aJf9/C39
 BGlxtyFyok//yWp3oeJDwBxkZk1xC2dsU4pxcPGMWubORercdIRiSgKxPzw3o6bd8mfO
 wMoA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1793720263; x=1794325063; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=H8lacteXxIpEXxT0WyruqaRka3glnGmTDLip0Kh6bxY=;
 b=Y6ZD4Wsi1iYJv36AzEwbuPlBWzzBpqJ0rpTwNqhM8zd0pTZLgWoK1EV2haBrigZGFi
 QiTQ/LzPkIZHEVqx0xWM+MIauHGCwJbJ1YKEO5Irvb3duR8m2xUQHW/av9h+cav46eFG
 vnyil27fuWZ1tblliNzO0HPh/4acSYaxVnO3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720263; x=1794325063;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=H8lacteXxIpEXxT0WyruqaRka3glnGmTDLip0Kh6bxY=;
 b=m+K7pQYvMX32/PqDLt2VRso59/+Cnrs+6SlybtMyIO5OtyrdmWshcBrGdu2Zbdq4Ol
 y0nmN2S1kKH5CkM6Jmll3ZzmZIL4dwPOpTWYTq5bi1PVokXND8YlHoEBTlZYCvLy/wAP
 H4mpFNj/4AtFmE0MdIFP3+p612rtsMU9p0Niikcinveh95s5rVHwKjIvqKtmdFkjplD7
 l5MZs8lgE4Gw1PCU2grhZK8BAnJK/VysIZnAM0uv9Xb2uwzFRzKiTJiIW40ZQucXN55z
 teX38JK81byAFSrsnZQhhAZ1j9e2tLD0366ZCFcyVUKBng+11MEmQxiJFTNKxwFvTVy7
 GfbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBys5n9zPvKRlDQxpCuGuaxR+/SMa0zJKjpeAjx6QdDtFqXJLYzKdU/YmLz0yQAspOmuYEI=@dpdk.org
X-Gm-Message-State: APuU4Z+++Y/Jmh0MrH/spiuGHhbYPpxxXCYXp6BwND/XXIwWtzRxR9iL
 Fdn5TzxJ+86lBSP1FQMnkBpnTnJkuvsahIW3S9D4Om2MEjlA8QRy8+8XR7hpbjfvvGMVEYgr+L0
 Sj2scVWXwlP0uiqIJb3dljzUJZSDERf6kn7r56TVzNQ==
X-Gm-Gg: AYBFou0JWTJ5iU36PAxRXyN6aW2hax41IF1Bky4JJ044AR72SyJunWbMYa4DGqlXY/7
 aAePvHVsn965ZB5H5IoYu8epHMqNbguo4CxJmM8c8jvWSDp9TbdbLbOJ3sphocrAHJJdaL5idbf
 D+FlGwv1EKHfG/NvsJ2XQ9ClzOCjNFyOl9npHXTRrXDO/AUvW10n09qJPsFHNOrm0smpUk+iokC
 DgyU+aciQskdQ5HkNPym7m+9daaWsInwhiQDG69VsThSBXgloUwmKmGWDXKnzGnEQtI0OZOtL+g
 16BQbJFFIQhoORrgyIGUc2bRw7bODLY9n+joDIZaAzIRo8a3lwwjsLwsMdJrj8sA4o/4uv4RdRt
 2mKbNKg0ePhs5SWVCnAhjixM+Ufi+glyC4edG0c/pjxKO90UGo4tlrPphaWigm0UAdJTecbFSt/
 uL/BqjNlH99hV0hHLmG2tuePkAGDTaTZusEpGPPtflHkHVxVr5u31twSXhbdSCR4IPQC+/Kgrs3
 yX/5E3rxNa+Zuj53ndJ+D8+Y0IJ
X-Received: by 2002:a05:6820:2206:b0:6d9:277d:79dd with SMTP id
 006d021491bc7-714f2a330e3mr8797554eaf.58.1793720262700; Tue, 03 Nov 2026
 07:37:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261008191139.1094155-1-knimoji@iol.unh.edu>
 <20261020173029.162255-1-knimoji@iol.unh.edu>
 <20261020173029.162255-2-knimoji@iol.unh.edu>
 <cd6f3102-3317-4f0a-b984-b4c9a793f24b@arm.com>
In-Reply-To: <cd6f3102-3317-4f0a-b984-b4c9a793f24b@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Tue, 3 Nov 2026 10:37:06 -0500
X-Gm-Features: AclHuK_dBdhkrhFwzniR1tXPWCWUUvfg4VPcSH7dXNU9moAzpJS0GSSuliaFXU8
Message-ID: <CAKYPG+z88eQG1zPcSZpQ-jKhsfKuBATcnqoS9wUq0=cKe+Fn4Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dts: add pvp multi paths virtio performance
 testsuite
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, dladd@iol.unh.edu, 
 abailey@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="00000000000015bf2b065f610b3d"
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

--00000000000015bf2b065f610b3d
Content-Type: text/plain; charset="UTF-8"

Hi Luca, this is the virtio single core performance test suite, very
similar to the vhost single core performance test suite. The difference
between the two is that in this test suite the virtio virtual device is
provided one core while the vhost is provided two cores, and vice versa in
the vhost single core performance test suite. I will apply the changes
mentioned in the 1/2 in this patch as well, and send new versions in
shortly.

--00000000000015bf2b065f610b3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Luca, this is the virtio single core performance test s=
uite, very similar to the vhost single core performance=C2=A0test suite. Th=
e difference between the two is that in this test suite the virtio virtual =
device is provided one core while=C2=A0the vhost is provided=C2=A0two cores=
, and vice versa in the vhost single core performance=C2=A0test suite. I wi=
ll apply the changes mentioned in the 1/2 in this patch as well, and send n=
ew versions in shortly.</div>

--00000000000015bf2b065f610b3d--
