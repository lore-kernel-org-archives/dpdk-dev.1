Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21666CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 18:25:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51D63402D6;
	Tue, 23 Sep 2025 20:25:30 +0200 (CEST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com
 [209.85.219.54]) by mails.dpdk.org (Postfix) with ESMTP id 06E3C402D1
 for <dev@dpdk.org>; Tue, 23 Sep 2025 20:25:28 +0200 (CEST)
Received: by mail-qv1-f54.google.com with SMTP id
 6a1803df08f44-71b9d805f2fso54854776d6.0
 for <dev@dpdk.org>; Tue, 23 Sep 2025 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758651928;
 x=1759256728; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JEQEtw7m1tQUg8IlGAsEy/VtrmB3yVPA7Gb2xTpg7E=;
 b=cnTIkq52vbp+M1PyADF39K0QsrQAqqH7rGdYRnySMuh4W7ExcLX2yt4gJvuI+oD3V6
 SNbk839VqjP9nkSv8NwfpuU+zzLrueKOtfXtWYH1eeR8NyppH2WGnfbP5akvTiBB0SFs
 c6pvpN7z7MyO2mBtq+7tMgbEO2pCHti+35Gslc97O9biyi7ekXTbHofau4MTZnbrMqs5
 vCdETQYpxYwWZqmzqGPKfVmFAcm4nKc8DwuU3wqNGtGN35YQw+jdNtgHBuM086x3N0Eg
 6IE+WwXzkzAkr29AmPqA8nZcrU4i4o11FaThXTwsXh67KMWuiM8f3yMsuLPts4fAKA3J
 H5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758651928; x=1759256728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JEQEtw7m1tQUg8IlGAsEy/VtrmB3yVPA7Gb2xTpg7E=;
 b=wYYxBIxUAF4CePpZUrPuuerK6Pmw8oAM8ylKKOKh5epKrpl+Z4SBmVGEl6g37dz5mI
 tL8InktUCJ3Sb44h4kHOUqAvGK0qek22VT6XslsEI6cGlLHMJQ07s9Xhz5geBtINiSvW
 uZ3umVNe2INBFRwIlNe+pUl7qIiNgNAogfHBe8ZELIBuZVjJcgHmddiNpSmTPB1iLmc1
 5o4ogkxyNAJHrUQ5RvXIoGPo+5jVE4sflZNKR3zEvaHX81vrtK3tTS7XNzG9rVAk+cpm
 VNN3KvcvzcxRmkqJgwklqQ2bskJ9leFOFG8GVYUKpDpMzfo2oyO8UXJMY4+poQn2BdsT
 VEPQ==
X-Gm-Message-State: AOJu0YxKx/SzfPHG1M10I/SRrdg+D0vM5Fv2HIGcRdTv11AqGc4CuFKS
 CcfL2XM/vYkYl/q2YuK2olDycLxGTnwX6AOUT2Yx/Zs1KJi448aZZzh5cXDUqkoSDfCd/aYfSml
 0/6+C
X-Gm-Gg: ASbGncvTwBnLqxmHf9RCY/6n4d55rfn1+PeInAvvAvMI+xM86lPtOkpb+3tdf5gU5wg
 pZSpXIdPEOVwH1/xrDepcLmpPyH/VW48eThqK0VBrvn2FwdaxRzVmj76Bi00Nyb4iHODeLtIN9I
 BpcbeVK97f+Qe8CfcY8vkwwmqjdxfwToc+ew+dc1EKqrwtSdXgudTuZfLAdWGVSrKmBN1r88vix
 FTLwk7IJpVtmoEryffaox3b0+cQNfz1IGJjQxTKn0j9CHegrf8cUT6EhfCs6xVywwj2yY1oqXJH
 Fh3+PV6lhaIG4u0D6SC6IV4k8PaAOTHAQKk8HysE7eFmv7wqpP99cFGKG/cg745dcNZhB6WQMVj
 p+o2II1iCWKOrmwOImtTXiYHir2SYtRMR/7yFz44xm8vnr0zWcA2OyeuHYKSx0mBH5N5nLCXq1r
 0=
X-Google-Smtp-Source: AGHT+IFGNR3qEYqZHfAbJ+d64CnEmH1Kzp11+vo7VotRwVuMKGXORPNp/FhZS0VuN58hl40NSKdeVg==
X-Received: by 2002:a05:6214:1d04:b0:7c6:bbaf:11b4 with SMTP id
 6a1803df08f44-7e71b3344e8mr41580596d6.54.1758651927930; 
 Tue, 23 Sep 2025 11:25:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-793548c7c21sm93599446d6.59.2025.09.23.11.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 11:25:27 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:25:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v10 04/17] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250923112523.6579c851@hermes.local>
In-Reply-To: <20250923035402.1759922-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250923035402.1759922-1-dimon.zhao@nebula-matrix.com>
 <20250923035402.1759922-5-dimon.zhao@nebula-matrix.com>
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

On Mon, 22 Sep 2025 20:53:49 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +
> +static int nbl_chan_task_finish(void *priv)
> +{
> +	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
> +	union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
> +
> +	pthread_cancel((pthread_t)chan_info->mailbox.tid.opaque_id);
> +	close(chan_info->mailbox.fd[0]);
> +	close(chan_info->mailbox.fd[1]);
> +	chan_info->mailbox.fd[0] = -1;
> +	chan_info->mailbox.fd[1] = -1;
> +	rte_thread_join(chan_info->mailbox.tid, NULL);
> +	return 0;
> +}

Using pthread_cancel has a couple of problems: pthread_cancel uses a signal and there is no safe equivalent on Windows

A better alternative is to just close the pipe and then the read
will safely exit the read().  Something like this:

diff --git a/drivers/net/nbl/nbl_hw/nbl_channel.c b/drivers/net/nbl/nbl_hw/nbl_channel.c
index a68060799c..c8572b3b4a 100644
--- a/drivers/net/nbl/nbl_hw/nbl_channel.c
+++ b/drivers/net/nbl/nbl_hw/nbl_channel.c
@@ -551,7 +551,7 @@ static int nbl_chan_task_finish(void *priv)
        struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
        union nbl_chan_info *chan_info = NBL_CHAN_MGT_TO_CHAN_INFO(chan_mgt);
 
-       pthread_cancel((pthread_t)chan_info->mailbox.tid.opaque_id);
+       /* closing pipe will cause mailbox thread to exit */
        close(chan_info->mailbox.fd[0]);
        close(chan_info->mailbox.fd[1]);
        chan_info->mailbox.fd[0] = -1;

Obviously, I don't have hardware so not tested.

Yes, other drivers call pthread_cancel() and I am working on an RFC
patch series to eliminate all those places.

