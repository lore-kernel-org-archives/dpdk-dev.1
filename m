Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD460A2613
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Nov 2026 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fPe4jXOx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DEB340281;
	Tue, 10 Nov 2026 17:48:31 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTPS id 536A04026C
 for <dev@dpdk.org>; Tue, 10 Nov 2026 17:48:30 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8b6399ebb41so1998134b3a.0
 for <dev@dpdk.org>; Tue, 10 Nov 2026 08:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794329308;
 x=1794934108; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FxcDe1eEFw7birxZTQhwwF8xI9xWzw5LmKSSoHZ6XTE=;
 b=fPe4jXOx8I23A5aAcvAuLqjN22YSN5mIejTCjPb2avs7a7tN3GblWSKuvzbMJu9hsg
 MO/Hboxn0cPGtZJ0vQWGWoPvUtqRN1K0jRUSzCQ2qJ5mmZ7xFgw+WaBMmYNzXrg82gNs
 S56jDvwt/jRb8KSXJAOHVylmI2ZCPtqnu7vbtoTwsiwSvMo5wzbuF5iP5YLY2wCCuz7s
 /HHoGq9GgXMnvHlJIgeQzgsPs3lt1fFRpg3CRA7uNr1/h3zrbzLadCDT7LkhzOB6i1OF
 plQvJw3/3EzC6ws1otU2kzX1lOLhdddM6ouMr5paG93WPH4KdfQS6+J+Mo1u580/3yIJ
 YexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794329308; x=1794934108;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FxcDe1eEFw7birxZTQhwwF8xI9xWzw5LmKSSoHZ6XTE=;
 b=T2UE454pOBsQseAj9booSv5Xw9eRpJnYSXagmE/aeQB7zcXWWM7bGGrq7+lG9mbDnz
 jrH+VzVB1wOFFgB3lKRJrVRXaLD1EWLwQuIkMvEByLxAlpfOMG4BRzUhIEvvExNp2qvW
 I5Jr8X9M2skpCksrmeCYPm9vNuSt5JQxgz5lSpzDmU2e+oCoQnSENnUxxhCgO0vFLtkZ
 yd+KQpa45+2NJFiw18OiKMPtMwIa6KdEihEqRqXqz8blQijICDP64rh8hYWfLxQZVHeA
 BPMDQkH33bljliqc/yCkUaiZ7kd5pkBEOz7B/0SKcdldD10KHpVcrkqnyPOrKGkLhGGo
 imRA==
X-Forwarded-Encrypted: i=1;
 AL+hErGrBu8Cc9EHv6fOsGBClyH9jnrwJ3uy/UjoNK3vSkF+ydPzjQZYaBK9RgvMW1/QFC9mUQU=@dpdk.org
X-Gm-Message-State: APuU4Z8UcshybSbYa+ph8E2Hpz8cv3xcC3LzmgpI3J5cV4l9hnSA5KY7
 2YGCAsBcyi0RipBVxc2/J18WcjvteT04LYxqNuTX9IUSRrZzc5cTh66P/Ni3IVQxotY=
X-Gm-Gg: AYBFou2RY/5jGpV2d9Gi5xyoySlSlZR28TBiX5qCp547sm4gaHTi41d8NjU8QeqKUZD
 hGO8rJonmSTGl7XOQP3oOvefZtPvpWMaj1xkKoXqlCYK25tQrZWOtnOrum1+8zzNwDAHqfypVyw
 wGnGLYT41LxU/qJtxITIZT3VDhWpEChE7fr0KBGDMyZAgPdkjuN6yYB8KZi6QZ7sASgFXTBX0Fi
 Fzmigbyde8Dt+YWM8hzXGFFh8Pc71hLUPlt/EbRT1zx2QPHzXLj144ISL+DYUX2volPjKYQ7UvU
 ZIS5lXS6+cWZc+ZKIJn6dqq8QrhgtM77y7wlqZ8mhaVkuJNfFYiDjPGTnW0745FUZ4uF7cQBOxB
 mv7Apt7AyePAsvX7cr04oUEGXGGX3ewg4EukQwIGyV6+9GdoYqMVuPXLI2lIKAGmeBqHu+2gTDM
 9uHEIRruCedTzBpe7ORkausPQMNrNyDvcMLO7Z1kvBgBM/anWG1fq76q7FXaevGVrYaSAL5nAgU
 wPuPOK7bMiLp0g/RE8S3gV5F/PF6W7B77faTY8a0IUOna5BA4PEpfkEviIYVMs/FYDX3ntg+woy
 D31A9BbWGddD/Xnjt5hut59Ps47bk7xOQxBWjxbttL99VCgfonHhApXwqQ28pUuirdoSylk=
X-Received: by 2002:a05:6a21:3986:b0:3cd:3e77:1dcd with SMTP id
 adf61e73a8af0-3f18c119fe0mr3240379637.1.1794329308559; 
 Tue, 10 Nov 2026 08:48:28 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdd8d7a26e5sm1062372a12.18.2026.11.10.08.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:48:28 -0800 (PST)
Date: Tue, 10 Nov 2026 08:48:24 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Marat Khalili <qm2k21@gmail.com>
Cc: stable@dpdk.org, Konstantin Ananyev <konstantin.ananyev@huawei.com>, Ray
 Kinsella <mdr@ashroe.eu>, dev@dpdk.org
Subject: Re: [PATCH] bpf: fix index register for classic BPF indirect loads
Message-ID: <20261110084824.3e18d6f0@phoenix.local>
In-Reply-To: <ab83280e-4e1d-41d7-8c26-5617bdb84a13@gmail.com>
References: <20261027170619.2193021-1-stephen@networkplumber.org>
 <ab83280e-4e1d-41d7-8c26-5617bdb84a13@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 31 Oct 2026 18:58:37 +0000
Marat Khalili <qm2k21@gmail.com> wrote:

> Converter code fix looks ok, is there any way to have a test?
> 
> BTW x86 JIT seems to still allow negative offsets in indirect mode (we 
> only fixed it in ARM).


Negative offsets are BPF convention to read meta data.
For cBPF which has socket filters it is how kernel reads vlan offload etc.
But current libpcap does not generate socket filter negative offsets unless
doing live capture (ie to Linux kernel). It might be useful to support
a limited amount of DPDK specific negative offsets, but that would require
coordination (or reimplement) with pcap_compile() in libpcap.
