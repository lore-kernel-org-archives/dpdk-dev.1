Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145DEC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:12:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C543C40276;
	Tue, 29 Sep 2026 10:12:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 818DE4013F
 for <dev@dpdk.org>; Tue, 29 Sep 2026 10:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790669553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOZxcnkc1llvdAiGnwbiUzffNoq4xyhoH2UIyn63/eo=;
 b=eAfCdPMMZ8EGCDabrzu9QJekXGHqC9Jb5Qql9DlIBdWMzFIyG1BgTnYOEP/OBNMynV4oR1
 6AfADHYJRohfKRgzmd1NmIiMv4/7L5/buqTd6rryD6RWG7+RJ5dM2/DUkLRfmwRGze3fMW
 RhpbPwZ6wgq33Ku/h6Cv1PSjp3Cnq1g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-VX5W5IKsPJKcrruw9V4ZzA-1; Tue, 29 Sep 2026 04:12:32 -0400
X-MC-Unique: VX5W5IKsPJKcrruw9V4ZzA-1
X-Mimecast-MFC-AGG-ID: VX5W5IKsPJKcrruw9V4ZzA_1790669551
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b8f5cc6b5aso868840e87.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 01:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790669550; x=1791274350;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DOZxcnkc1llvdAiGnwbiUzffNoq4xyhoH2UIyn63/eo=;
 b=nUReVY/dkvSixcsvPtLw+zb9JB/FYCmjpSjSiO4wNUDkUv97f2n4SBRajO/tO5UvVX
 oqwulfqaMvh3ULLIUxUoRZWGlEdmzAhdl/exnPNTOK/b1+vaa1WsmHnBKkdMYg3aEcqz
 OO1MZnixRSbfL8CXrgqWUKjjDvSUp8+HUSJAcYSgm7EnImiMbedwfxIAN37eBmAmoylJ
 8uuAeXlf1pw7JJ+RoA2corVSfWec0DpCMy+is19ddLM0AKhP+FWtka7HZFKzuEITp5fl
 ei3dJKRRKtb4eKRwF7dO+BPT6xaJ4u0OTDNDrMuysHmJC9UNb3AC8pZLiyJFEirXNTm9
 AF0w==
X-Gm-Message-State: AFq9FYLGyg3I0KVg14J8aw8p5nZdsLdoV5LSur6Xe/+WDlYH/1kD5FsP
 lfPhITnxmghR2jvAdmtAleTAw3TQnk4CdlNgaOCKlwhjzm+gaKsF7Xx2yBYcPeBsW0Ntn12j3VE
 2QnUMtB2NNzzx3vGxW+wy2U2BE+DqCgq+6ULA5mmiL0O7zLS4m0NFq9W+5k5YMf1ObR2uynFIPQ
 3cyq72IM19680R+Gt3frk=
X-Gm-Gg: AYBFou22f4F/rqn4yv9fwMFxJvZhrGU1B0yonXVS1XSDNnK/fQ2t+RQIB6bmusLA/iY
 gnZ3RAhp2Dt0mddpCujoipux09OrmTT8VUvWQL4cIhJu8/id645RV7/5ZGXulWEbHMRKGavnlOy
 D05ydb19MWvu3kWcvG0AaZFfA0ua2q1JCnB8EYLkSBN0qJonKQSqqVpWCSf4CJ7VYqK6Nkn5xOb
 uDMpxvHC8x8BuoSRFamksFf4C9zGGDmds6Slg6EN2HjO2gm
X-Received: by 2002:a05:6512:33c2:b0:5b6:1a7d:553a with SMTP id
 2adb3069b0e04-5b8df0e8cf2mr5293202e87.65.1790669550467; 
 Tue, 29 Sep 2026 01:12:30 -0700 (PDT)
X-Received: by 2002:a05:6512:33c2:b0:5b6:1a7d:553a with SMTP id
 2adb3069b0e04-5b8df0e8cf2mr5293190e87.65.1790669550068; Tue, 29 Sep 2026
 01:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
 <20260917201119.2168234-7-stephen@networkplumber.org>
In-Reply-To: <20260917201119.2168234-7-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 10:12:18 +0200
X-Gm-Features: AclHuK8qoLrOF_3BB3E2ZoPrc9sCB0PKkqqoXYvOUnAdtig31n_E3uDLr0fKP1g
Message-ID: <CAJFAV8xSd3Z6K=6_OaNwX7Om4iWPj55z5Tgb5tU9Yj_CfaN2Mw@mail.gmail.com>
Subject: Re: [PATCH v8 06/25] net/enic: do not use deprecated rte_atomic64
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, Hyong Youb Kim <hyonkim@cisco.com>,
 John Daley <johndale@cisco.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fHuV7oh8jRnb2SZCDSn8lEqiOUWyd7CD5ZnVuMI7Ry4_1790669551
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 17 Sept 2026 at 22:12, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> diff --git a/drivers/net/enic/enic_main.c b/drivers/net/enic/enic_main.c
> index 2696fa77d4..fb9a5754c9 100644
> --- a/drivers/net/enic/enic_main.c
> +++ b/drivers/net/enic/enic_main.c
> @@ -83,17 +83,15 @@ static void enic_log_q_error(struct enic *enic)
>  static void enic_clear_soft_stats(struct enic *enic)
>  {
>         struct enic_soft_stats *soft_stats = &enic->soft_stats;
> -       rte_atomic64_clear(&soft_stats->rx_nombuf);
> -       rte_atomic64_clear(&soft_stats->rx_packet_errors);
> -       rte_atomic64_clear(&soft_stats->tx_oversized);
> +
> +       memset(soft_stats, 0, sizeof(*soft_stats));
>  }
>
>  static void enic_init_soft_stats(struct enic *enic)
>  {
>         struct enic_soft_stats *soft_stats = &enic->soft_stats;
> -       rte_atomic64_init(&soft_stats->rx_nombuf);
> -       rte_atomic64_init(&soft_stats->rx_packet_errors);
> -       rte_atomic64_init(&soft_stats->tx_oversized);
> +
> +       memset(soft_stats, 0, sizeof(*soft_stats));
>         enic_clear_soft_stats(enic);
>  }
>

enic_init_soft_stats calls enic_clear_soft_stats, so a memset here is
unncessary.


-- 
David Marchand

