Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9EFCA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 22:05:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D50E4026C;
	Wed, 20 Aug 2025 00:05:30 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 5DD6340151
 for <dev@dpdk.org>; Wed, 20 Aug 2025 00:05:28 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b00a65fso30401585e9.0
 for <dev@dpdk.org>; Tue, 19 Aug 2025 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755641128;
 x=1756245928; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlEd/y55fpihvtwbjZY9wRIVJdFy9MGcmRKQzcc6hUs=;
 b=m9PErmLCuCM88CnU3dOzBhIhDxa/jGjyOY17uItrUy1H7QlohUKQdDUNkKIDfom2OO
 1g5+bURspYVDMkxP19stuaEhMo1TW09zUgrsUuOQXYLrNrA5hSr4J15FTS2/DHVD6Tuz
 cVU3pSR8F4jB4dFONk4qRe9jcEd6+q4uLS8nYacmQUSPUtkLrcZCO6keUgztJ7DptIE+
 yxeImLFQw2/yXcT0n/I/a5QHKDKkcImNKya92eLrVK81/+ZpoPcafAMRVR/TmSvKL+HH
 S02c36BrkJsSUwpVcucJxnONCPwTwOU2+02yVCnanvem3uqme9VrEBrEJjJOgWUVufe7
 7+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755641128; x=1756245928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GlEd/y55fpihvtwbjZY9wRIVJdFy9MGcmRKQzcc6hUs=;
 b=JCwLFxE+QIB5fiib/O35XdIdpAhSG205DxpcHk7hU5A9uBk2u9ffE69vSqoGUkjO+Y
 9pButLTn+loSwGxORUjTft35KtMS0seAq+wWuzD7Lbnn1BYqMZulx2RYsoJoSsaCHraN
 Ghh1B4hw14bXBDmR1e9nvaRr77OGuYsgmoAOocg2BTrSg4UW599BYQKz5ImnArMw/fhv
 PkPdT9kQ3CGGZrxKQsIrLh+AR2ARebRv43+T+fq7Oik49IPkpaoGdAHtYzKMXt94aUtI
 zbt+jWBU73eL2iAJZwgo1CywdYEVUwbrN4lqbjrxGAi3LX4U9R7VdzjCGATArm058IFJ
 nUYQ==
X-Gm-Message-State: AOJu0YxB3MQzEJXTRaaltJJRGD9knoGGGDq8bvX7VNaI2KsXZqKB1DYl
 eLoN6dUlaR1tLwN1IeI/dkX8zlhg6RLdawel8uHMMCMR4qCCAorbAEHFyipO314GCdSRlRuxzMv
 ws0wG
X-Gm-Gg: ASbGnctLQhD3Sedf1JkgddzScZnDgwVHh4z/mtzxxhX5AjCTm+L9qa0E7u42x/K8Gms
 TH0OWMMbSmXi76Vv6NMhuTwpKwM0KAwUfmXY9WtH+aBfU5Hr6FT5ZAUm9Wug5G5d8y3yr0Y0vJs
 oHbFz1+hoiD6h/8Swz/Qz1tXP7nB7Q8FTgvINTU6cuczqKagtGNc1JPotzrrE3s7P5teVZgKAu1
 H4zArBxh8DCD3ldA8aVHr1M7yH+2JNS9ILNqxlMKoSLaVGS81rX2qr4nDAOxhxBfC4iSiraSkZQ
 u7Z5nNxS/e0bBD1UffmKrqh6WigezUBkxjELXsI0ccGEpo+FVNOD4ZdDRkbRtYawTCsal6mQGHg
 yJmelUh+CYUcWRIjnTxKGsTXDQ4N3fq0gCXIVWKv9uAVMl7jlFBz3Ds6mEioxIcCrsa6iubGHX/
 Y=
X-Google-Smtp-Source: AGHT+IF77oZfW1pXXYDBBdXx124EwnY8Jmqp2JNMuRP0Tem8t+vlL9YUeFZuj5laeJsTNquCk08b9w==
X-Received: by 2002:a05:600c:468e:b0:456:161c:3d77 with SMTP id
 5b1f17b1804b1-45b47fe0f81mr403575e9.16.1755641127594; 
 Tue, 19 Aug 2025 15:05:27 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b437e9232sm22830305e9.2.2025.08.19.15.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 15:05:27 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:05:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v5 04/17] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250819150521.631a9e85@hermes.local>
In-Reply-To: <20250819102237.3067518-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-1-dimon.zhao@nebula-matrix.com>
 <20250819102237.3067518-5-dimon.zhao@nebula-matrix.com>
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

On Tue, 19 Aug 2025 03:22:24 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +static int nbl_chan_setup_ops(struct nbl_channel_ops_tbl **chan_ops_tbl,
> +			      struct nbl_channel_mgt_leonis *chan_mgt_leonis)
> +{
> +	*chan_ops_tbl = rte_zmalloc("nbl_chan_ops_tbl", sizeof(struct nbl_channel_ops_tbl), 0);
> +	if (!*chan_ops_tbl)
> +		return -ENOMEM;
> +
> +	NBL_CHAN_OPS_TBL_TO_OPS(*chan_ops_tbl) = &chan_ops;
> +	NBL_CHAN_OPS_TBL_TO_PRIV(*chan_ops_tbl) = chan_mgt_leonis;
> +
> +	chan_mgt_leonis->chan_mgt.msg_handler[NBL_CHAN_MSG_ACK].func = nbl_chan_recv_ack_msg;
> +	chan_mgt_leonis->chan_mgt.msg_handler[NBL_CHAN_MSG_ACK].priv = chan_mgt_leonis;
> +
> +	return 0;
> +}

I don't see the point of the ops table here?
You are allocating it in shared huge page memory; but it contains pointer to ops
table values that are function pointers. And due to ASLR function pointers are not
valid when using primary/secondary process.
