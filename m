Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E883C9830B
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:39:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0359B402DB;
	Wed, 23 Sep 2026 20:39:16 +0200 (CEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com
 [74.125.228.42]) by mails.dpdk.org (Postfix) with ESMTP id B6B154027C
 for <dev@dpdk.org>; Wed, 23 Sep 2026 20:39:14 +0200 (CEST)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2dso623736a12.3
 for <dev@dpdk.org>; Wed, 23 Sep 2026 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790188753;
 x=1790793553; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1jLI650VvjuCg7UeZszb/eJ3kcO7rfo/BGaTB5okzQ0=;
 b=We20N8E70xvdfe61I/mvkdchFAj/MK7JMv3tgkdPiHNCreKRFcEfijtzAIuYa0IKO7
 3Hnsy8Qa8EAmxIf/BAzkEHjfUHnIKcGXTjZI4qybu9fjceP4u22xOExPzzv4ozO/+5Xa
 imFkekd2+0FgCKUJ2SNhZNMcHfilKVS3O1ATDRAtAInRFCtb0OABF6iJ247wKxC/UEOc
 RbmlPZnt7YNmrHkUeFHXW3dNWWiC+V9YrUkQ7iJu1c1bRT0skWeSqj87Rt3U+2EWfZdq
 bZH499kBroTxm8IwgbxTWeHwsuKZjAGHEeh06nA8hvq1xPUWAg5lSgZi+QDgaHLJco7B
 +4WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790188753; x=1790793553;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1jLI650VvjuCg7UeZszb/eJ3kcO7rfo/BGaTB5okzQ0=;
 b=vug7GbMdlsNwgmJVFpcDw/l8E/u2iDp7PTCGzcWVarSOLcqteGj+5a3UoreeYSkqDl
 rp1jg76aLEZSNR0Ks6AjEcEcmTTrDrUmyn0u97dEgNqFT769Vw9eCfHLoVy5+XcT8q4Z
 ESHeuJr2jam4XTEWpvgT/tDjHRPMQEEvsL6Ua7M+xTxb5N86z1JE7OMNwcEmK8cHIlID
 lApc5QwLwvMQP3uSL4E0TnL5FrCljL3HRt3wQ7SdmA7V/LLS2t+PbY+FBz8iR3sonS3O
 rZ70G+2y8PteYp1iLS9WfJh7TwGYjL/K0AiaqfQNJVQjYCqZYDFJhTuNLjqMCy9wnLr0
 gEwQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzi2QbfZL7HuOz861IBSNvSHvfbECLKuAm4OCvSknrxDz+RiCi4BcMfQq1jO1vaNVxwLyc=@dpdk.org
X-Gm-Message-State: AFuF++kEv8zyvfpZymzyQLIivCh22qSOGAFtdcIg1sFv6u/En9TVgIqH
 E/7VLRjy70GJBqshe5Jqb+z4WC3BqGBGb3XGMGKpCF5GlFuDsUxJOBDQvctdedXiOcM=
X-Gm-Gg: AYBFou0Jwj+sNnHnMGFKOgiHB0pDgWOSiZ4cLSU3Qbw+xHc8B1GHCpnCE0MwUKniAhk
 K6cffK+0pxSZsl7CKWvNS0bMRVpnDB+jaTegbv4d36tl2Nsi65rz+PaNHGDNP/GcV72smDb6t94
 /YjurlxeEdOCFf++p0pIx0Bvz4RE3TYQ7blyBh+f2h37+EjTQLNGUH4itFASpzWTQvuyY4bbz0J
 WlamdIgxV0YM/vZ0c6Fn0ln+vFViEVs3ZJhzwslea2Ju2hEg/JE+3kuG/eYaCpFgjSaOroPgfND
 ctGF4mAiM1ecaTtbWY/2OJv56RHppbkJ3NyKwgDlwAQK/+//5f5436t5qiPUClDPzhZ3kvHkjh0
 9RXc06vaMypxNppHuUGmlTgw4sZ9ebpuv+2Fjz62R+/NpU8LCzaZnt5fNUu9oHcrUgTM3/kp9w9
 7/OyKhIve6mV/lYoSA9gg+EBK0xQVRYlWNeC6x3Y/vpJ4dfyxD6HcUUI8QzijI9BuuFMaATA9Xa
 ABQeJrfNAZ65bzcxJGCsX2QmNSx+GspXrrbZhJc
X-Received: by 2002:a17:90b:3c07:b0:39e:4c7e:f03f with SMTP id
 98e67ed59e1d1-3a098b936bamr32592a91.28.1790188753433; 
 Wed, 23 Sep 2026 11:39:13 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0972b22c3sm408583a91.1.2026.09.23.11.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 11:39:13 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:39:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <ykanaujia@marvell.com>
Cc: Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, <dev@dpdk.org>
Subject: Re: [PATCH 2/2] drivers: add support for async RTE FLOW APIs
Message-ID: <20260923113910.7c6bb91c@phoenix.local>
In-Reply-To: <20260715084545.301064-1-ykanaujia@marvell.com>
References: <20260715084545.301064-1-ykanaujia@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 15 Jul 2026 14:15:20 +0530
<ykanaujia@marvell.com> wrote:

> From: Yashaswini Kanaujia <ykanaujia@marvell.com>
>=20
> added support for asynchronous rte_flow APIs
> for cn10k device
>=20
> Signed-off-by: Yashaswini Kanaujia <ykanaujia@marvell.com>
> ---

AI review found issues with the patch.


  f58b114027 "net/cnxk: support async flow API" =E2=80=94 the code is genui=
nely
  well-written; I found no memory-safety defects. Bounds on nb_items/nb_act=
ions are
  enforced at template creation with comments naming the fixed-size stack a=
rrays
  they protect, template indices and queue_id are checked at every entry po=
int,
  refcounts prevent destroy-while-in-use, and create_by_index is a delibera=
te
  ENOTSUP stub rather than an unfinished path.

  The problems are process ones: the message says "for cn10k device" but th=
e patch
  also wires up cn20k; ~3200 lines as a single commit with a 2-line message=
; no=20
  release notes and no cnxk.ini feature-flag update for a new user-visible =
feature;
  and a stray blank line removed at cn20k_ethdev.c:8.
