Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166D2606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Nov 2026 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KKjuJL1V
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42C13402BD;
	Wed, 18 Nov 2026 10:26:29 +0100 (CET)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 777F9402BD
 for <dev@dpdk.org>; Wed, 18 Nov 2026 10:26:27 +0100 (CET)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c50e9408873so88053866b.0
 for <dev@dpdk.org>; Wed, 18 Nov 2026 01:26:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794993987; cv=none;
 d=google.com; s=arc-20260327;
 b=HwjBCPF7ZXsqhgK9TCRVTbjrbkzIbWI/oR7n48tFtuP5cSUgHNB4cwXTm3KG6NcPcu
 aLxpOKxAjt3VXeJRMECpsVbB66cE+bJBkRxV0IZkCM3516Rdn0aX0zqQIAs/p9+Bb0hP
 JkyhF19Zl5OvV2he7QoLrnFsMblQeWvzHGCm5tf7Tcrjswa2Z5kCiDBZgRzoxtoe92Rz
 53lqGuFp47fBKUQLDwKGkFZuLRfI/IkFyjx+oM6LTxoko7AgDKn5cn6DTBb1ntyv8tcj
 mX4/9bvMNEe2SBCac0vzgiXZsRJ4nnuhTBPkcIk970Jfdo70+wNnbOsTffnlsbS7KNgg
 b5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LYwq+0xIbkIhm9SA1iEdwbhdnTlfA95TvNi7ysDP+Mg=;
 fh=k98fVe7/L02o+4gxMJSaMkuNaCQ9oRMJmFViXrZZot8=;
 b=stsLUCh7i9oUhxeetVixp0zg+BsB8djPa75DTTofA9p5QUolNV1Wl0GTS2DmyoaOS4
 ApfG+oP3uP7kyLyVFRO4opKT5u9wvdiwyodvoO7NTndpHyn2rlhOE0fm1FWXyFHOsPyg
 xStju7uvbDjkLK0Jmp9R9kmTBYxvUn1Ovk9ddYIT9f2mXaY4wp656WciB53ox6DL7DzB
 zBMEMkf0py4HUwdWeKE24m4Q5dgyIqd0uFzlzdBC8hXwKdvOYGwvGyvpKwvivG1LOtPs
 uCLsJcbIUaNgkZkpBzKei1JC1RKlVQcq96kOdpkbSaBoSVS9o+JNhuuHkDUkT9Ofai3R
 AC6g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794993987; x=1795598787; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LYwq+0xIbkIhm9SA1iEdwbhdnTlfA95TvNi7ysDP+Mg=;
 b=KKjuJL1VriVRsSFcEjZFpIeLhukPJB6LmkEG1pWWJClxhe/QOdOhdGK5yIigVcOB/G
 KMbQ2SW/A70eE5K3OOoHpx0g4qy9yNhf7Jxahb0w0jiZg9IjjvU4Wp5Eschz+ee8094a
 JDRMwHk0o1/2oyOBar4RQSpkN8EMUHWoc3MmSnpDRj4epoxp8QLETo4G+AXFmvd5Ruzu
 JlPo6iCW5Fowgly1rUnMEKB206EGiw3bViv7DgxKxMKvD+n1JKZeebO+kEattpymS8tw
 wlKTYVCIEIy0xAhcAndjpdONVZgSLS/diE8qjH7wBZpcf+TCe1xAOHGsy2YBc5fKQEiB
 sTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794993987; x=1795598787;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LYwq+0xIbkIhm9SA1iEdwbhdnTlfA95TvNi7ysDP+Mg=;
 b=RVJz0a9RkVf2Vu2FGrMxcWgQWLmQaH+L8RLpdPSXVy7/qRLUslVwNTU+z34dKl4kUI
 dKJf1rg77ZVGzKGdVKteyqwXYkT+Usii5cRi8USxuRBQp8a7Yb3C37E1PFEeKXt9i3o7
 Ht+J6uAv+sZ521myzdgcH8Z+5DTrCDmfeho5naPL0EZCeZmbHKT/gul3KPLCtpytGh08
 M1kWLVGpudl3sZQtTSruijWiSez/hxwkKSalqyBHo8KeknJHHDNxGT5/Yh6eXbLQn+9R
 mv4EuzBa6zRG5n+McoUoIF9bWqseOLcgMJAi4hCrLHIvePJtizfNYJ4ERd/dJZGaSj9u
 LkdA==
X-Forwarded-Encrypted: i=1;
 AL+hErHoNOleTERH4p2VF9ECZxSHgLmXxWjer0y834UNUG/Ijjskjq82QPRTQpyVDAJhBN2wQtg=@dpdk.org
X-Gm-Message-State: APuU4Z9+JpOBVa910v1M2Gg2iwxE59eTMzkq8F++E6d+ZL2zVptz6IXI
 U5N/lrTfUWwB2y9qip5nhZNv2MsHuR/TyTxsDlLLGHZIeIJXswq7jVa2w2bfQXI84cECx0ppB9X
 Hc9G4ERhegrmSmwT1IEUSbdZl1v5ITds=
X-Gm-Gg: AYBFou29kQ3u1feBxAGE9dXnu6qe6qzncGeGB5ZYkk0ExtC/hfg/zsiRFpM2t7wR/1A
 iISZqHl2dkMn5iHBv9Fplr4ySh3xwUKLkQuzDm7GvmX7PC9Wf3KrxLULMYqwKuBFVRdJf3FVtUu
 Pwr/Z15/EqsmZS1sLm/VaaMxgmjeqRMVBEWrvhlXONzCDprMvRXDcAYyrFd6hOaPv7w2D6nWhCD
 0mZ/QSOg7hersFkbu48y1xQ3fvrEi1DUYUupUloUrw5gxk6uhGIcpCqwd27XO12Y138vgZBFFsy
 VJZbqO4pdtdOf29ngY9Sm7ZNjdEkm74eVSl4TsTArZXsOsoPkhLS/HXosadIzjhhUBUZdNvzVH7
 nI03BV88M2CeyG6GCCUmv1vXwiDExl6Y8SoejP5m24EMEfjH9BGO8rmoT1g==
X-Received: by 2002:a17:907:d307:b0:c3e:f39b:2298 with SMTP id
 a640c23a62f3a-c510e19965bmr140172966b.16.1794993986779; Wed, 18 Nov 2026
 01:26:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117124303.717447-1-iboukris@gmail.com>
 <20261117124303.717447-2-iboukris@gmail.com>
 <CAJFAV8zyPB1uqYmywdqzwBCO9mhXrpyEJLyPf8bELLSvFK-x1Q@mail.gmail.com>
In-Reply-To: <CAJFAV8zyPB1uqYmywdqzwBCO9mhXrpyEJLyPf8bELLSvFK-x1Q@mail.gmail.com>
From: Isaac Boukris <iboukris@gmail.com>
Date: Wed, 18 Nov 2026 11:26:15 +0200
X-Gm-Features: AclHuK89HoXG_wOwa6k6hqqRYNLLHrbBpafJPKmqZIlp2OcXJwlxPEgYjNdmOAw
Message-ID: <CAC-fF8T1iOTVi7+g7n7g=ojtVpM87nsmWEcHyEF5Cz4WPoFhVw@mail.gmail.com>
Subject: Re: [PATCH 1/1] net/virtio: fix Rx interrupt setup with MSI-X
To: David Marchand <david.marchand@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>, dev@dpdk.org, 
 Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hey David,

Between the feedback from the upstream bot and my own, the series has
reached V4 and grown to 8 patches but they all centered around
virtio-user and are relatively simple, and the dust seems to have
settled down.

Cheers
