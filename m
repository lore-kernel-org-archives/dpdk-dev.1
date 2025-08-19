Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EF4CA0EEB
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 22:32:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC14C4026C;
	Wed, 20 Aug 2025 00:32:47 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 0B8E440151
 for <dev@dpdk.org>; Wed, 20 Aug 2025 00:32:47 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b0cbbbaso42428245e9.3
 for <dev@dpdk.org>; Tue, 19 Aug 2025 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755642766;
 x=1756247566; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzr13p5K8Yys4j3XGRoFF1vxZLLSLHQwlBEaqIj6bCI=;
 b=1zyycXRjFR+PFxz8IxY/ox749mTOq3rsYKMCB/YZs/6cCp73vR8a/qB7lgHrkXjDLy
 DxFk34XLIOQszt1S3jsVJbFg6c4r5rztVWn/kYF5ke4pc5Nvr07Rghi9+Q1PvjFQABXW
 pEt4p0jQX+db0oFLKQBdQH0AZU0BqhUeFuSa6W+Itp8R423M+jCE/OTWEHuVaSjXeIn9
 0hGfzz/7kltiOqCynDz84jaA4fQrYRK+dgrm1M/Z8hBT0fz4KQQEs2UQ4V675zrl5pyi
 CiropZ9XrJgwATvo+XykX6ne/wDmctuzoBdMvf+szX/N7qGL2n1/4x3QjfIP4ieHrPC5
 h5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755642766; x=1756247566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzr13p5K8Yys4j3XGRoFF1vxZLLSLHQwlBEaqIj6bCI=;
 b=it4bEPAq+0RqeONdT1vULfnuAxOrtLwFS8Xj2mw50JksyLNmyhNRRVvK6fid0Gdxpd
 XCXQ1WOY9zFzrdRYSY4GegoNPuozud722eexn8Ds2mu3qQZtim4XMVDaIIC48+JCPPHe
 i0/5nKHIYuwbc1h6l+GRqxukPR4Qv5fzdRC9ZzGUBCm2gpk9SWpya+xqId6pkVuYL95s
 ovf5pbPIArCr7Cw1kIQwUDxj5ZHR93Cgr3opZP9YFtxhpRekiZ/b8ow3LYlLwuHnYK+I
 cq9LOhr8YX1awIY/JIHVuO9DD3TUPjBUTDWMMxejDVXnN3EopwBT/7eJyt51N7M06YV1
 2r2Q==
X-Gm-Message-State: AOJu0YyA5vxicDWiTLkIVegZvU8s6p/3d4av6CwJ0qmUZVBgdenhWfaA
 5KBBJWfBv9FluG2R78GmXQbrVlbuHvJ7QAuTyOiajVuH/EEJTmr1DVeodvmjErmnkZ/EWeEZpes
 bR6up
X-Gm-Gg: ASbGncuU4PbPJaVcXYHG36hDX2duWfR63toAKHxBrds66Q+AaBqJvo6p8bmHlOD8zRZ
 aVlPDKwmZdeVGH1eKnL/vhvrOlhfzkY4siZlx+/PccTIJPK5KmB3b08mVOI/17SspnU5J+4egC+
 g30tFTRArq4MRyglWVMLIZTqAgPbomrfuHqL3E5F6OY2EYewnLiSnvbbQbJ81LBKk/zs2a74uXk
 B79NniKhr2hWkImlQRy6uwuiCfNixCKJ+LKadEqFVo3ytbWOVchjjsMjrYdTVuEWaxEawfhP3li
 RmlPZZXWgs1vCjT8nz7zyJhCmRi01LWESBaJwsbohrtEkiw+a7kz5uvGy5Ncbjx8eKylGCcp3Wk
 jjhZpTt6P4HPo2jPqY9D5wXGMfCgPQUHhmRlodelYdcfgd7uo+W9z4j5KCDM6T2s5zilSIcbCA/
 U=
X-Google-Smtp-Source: AGHT+IHr2krF+Gli2LZFu8z5CTO9Qq3KSh/FhJytA19MZYo1M0J1gsmMw1RfUTUsR42mAD9yDr4RKg==
X-Received: by 2002:a05:600c:1e89:b0:459:dfde:3329 with SMTP id
 5b1f17b1804b1-45b47a0aa55mr4394325e9.31.1755642765932; 
 Tue, 19 Aug 2025 15:32:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077789d1dsm5154272f8f.49.2025.08.19.15.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 15:32:45 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:32:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Kyo Liu
 <kyo.liu@nebula-matrix.com>, Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen
 <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 01/16] net/nbl: add doc and minimum nbl build framework
Message-ID: <20250819153240.7d6a2f2b@hermes.local>
In-Reply-To: <20250813064410.3894506-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-2-dimon.zhao@nebula-matrix.com>
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

On Tue, 12 Aug 2025 23:43:55 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> diff --git a/doc/guides/nics/features/nbl.ini b/doc/guides/nics/features/nbl.ini
> new file mode 100644
> index 0000000000..6daabe6ed3
> --- /dev/null
> +++ b/doc/guides/nics/features/nbl.ini
> @@ -0,0 +1,9 @@
> +;
> +; Supported features of the 'nbl' network poll mode driver.
> +;
> +; Refer to default.ini for the full list of available PMD features.
> +;
> +[Features]
> +Linux                = Y
> +ARMv8                = Y
> +x86-64               = Y

The features matrix is not updated by later patches and the driver does
support more than this. Please address in next version.


Link status - Device appears to support basic update here.
Speed setting - there is code in configure for this
MTU update - device appears to support this.
Promiscuous mode - has hooks for this
Scatter Gather - appears to support it
Queue start - stop appears to be in nbl_txrx.c but no ethdev ops
Stats per queue - there is code in get_stats already

