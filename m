Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647CCC71155
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 16:23:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B3807402BC;
	Mon, 16 Jun 2025 18:23:00 +0200 (CEST)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 by mails.dpdk.org (Postfix) with ESMTP id 256944021E
 for <dev@dpdk.org>; Mon, 16 Jun 2025 18:23:00 +0200 (CEST)
Received: by mail-oi1-f170.google.com with SMTP id
 5614622812f47-400fa6eafa9so3334379b6e.1
 for <dev@dpdk.org>; Mon, 16 Jun 2025 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1750090979;
 x=1750695779; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJ9XaCObqjo1YJkhdKc9TlSfeJP3yjqXGqyhUyESb/o=;
 b=u8vASe+oGpP80uSLrILAaVqgABxFVMAzSpg2uukTiR4D58xx7xX9N8yd6qo0xtifzO
 s4YllCCBRH7eh/V48VTMdafR9BYydruvpVJuSyTHQVBnn9AWwoG19Q6r0LcC6mKg4C2B
 Iwczmjcdt7qs9PJPKtfrvEIDAe/OPotnj6jtdeYg7RggFztp7fiirtb3ZOahIU6IxuZP
 /Q9CF2msQgaoiWudU0mquWjqnD8NDl/kroZ0levZbjbC2+lyUGqMh/1v3DeP1yD0yXW6
 8b5SswEVTYYpLTOSGv0hOFT4uYRnKjgVwFSlSyMCgi59QVcqMinp6Rvj8t1ILAzAAuem
 l1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090979; x=1750695779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YJ9XaCObqjo1YJkhdKc9TlSfeJP3yjqXGqyhUyESb/o=;
 b=ElTxg9kuF4NiKz0Lu2DBPRXjpOYmDPoUsRCnk6jLYZyducJ5W/TpIJ8cleRd/E31wX
 CTuT7BBcVUrxaOHhc5k0XgQdpzsldsYxePS/l7HzkxDPMwztyImOp77aWNAV9YzWc7WF
 H2wxE0FpvaxaF4YVB//nNiNFg+Xv7mUIUFcMEZyeruxHs4K9/gsTBI0Olfqz3Xfa5JbZ
 76sR1PKvCPExKgXfwsRSjaDT4KUYmJV8whOTykf6A7baZXVIQMQQpJ8CGpoqTo955tAo
 beP92AxgULi5i1X+k+qcbdOIzbbdjP+Cx2bUZEgotplL2xdnsDOCX3nz2w+rYUED5GBu
 fd1w==
X-Gm-Message-State: AOJu0Yxd50QLGm6dJcCzGqD/H5B3lpw61QAIEsIS7lSrNen1PHtYvpEA
 PiapPd8mZYX2Ear6N3C2/7/UC6BOTnExxALaIz27F9jkO0olVrrRjuBwP0Fh2wFlabbZ00q1n8k
 +s0/+
X-Gm-Gg: ASbGncusGRs+uRh2v7g7euWGu6nHvxOLhSwYnBozMVjdZHeM+D6qNO2fVDdAAko2qe5
 5YW0b74y3KPCny5Gh3ELCHDn6qviiH59Tlu2fgECwYj+RQjlVB2hEf0FQxT1yz2OKugkMPkBDzq
 JvOyEqa53wAj+/f9qc7PVBBzRt1RqOZxA0mDu/5NYdhfucN0ZZK1k/BUtPYSQ5lrjauAse+meef
 FG53+hQlrmMbbt9k06C7hSFvZwxxnP9bpITOknj14mT3ceyc5Jeqadotw7APL8z/w4yXiXjTx6r
 xnyblvvUFLPn1S5q+hXxOUJeW9DEiqMnZo+NqXIVbyb06417z2pJvinXQukBbCrfjo18o3reNdy
 uRmrxHhswqLZdUNZz4UcgyStT26cT7B0xU+bkJcY=
X-Google-Smtp-Source: AGHT+IGGEQxW2r5pcdgYAU0cTMCtAVdqwbBU4gm9kYT7Zk0k2zqdjyXm4UBOg+fnGLDMHSskmPcbfg==
X-Received: by 2002:a05:6808:ec3:b0:408:d05d:8915 with SMTP id
 5614622812f47-40a7c239e92mr6466945b6e.22.1750090979274; 
 Mon, 16 Jun 2025 09:22:59 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a2855872fsm1242876a34.69.2025.06.16.09.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:22:59 -0700 (PDT)
Date: Mon, 16 Jun 2025 09:20:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 2/3] net/zxdh: modify some VLAN related issues
Message-ID: <20250616092003.429477d5@hermes.local>
In-Reply-To: <20250607023020.3051575-2-wang.junlong1@zte.com.cn>
References: <20250607023020.3051575-1-wang.junlong1@zte.com.cn>
 <20250607023020.3051575-2-wang.junlong1@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Sat,  7 Jun 2025 10:30:19 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> modify some vlan related issues, and provided
> vlan tpid set ops.
> 
> Signed-off-by: Junlong Wang <wang.junlong1@zte.com.cn>

Best not to mix bug fix with new features.
Bug fix should have Fixes: tag.

