Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3F7CC6B16
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 15:12:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 17DB44069D;
	Tue, 13 Oct 2026 17:12:02 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 922A24069F
 for <dev@dpdk.org>; Tue, 13 Oct 2026 17:12:00 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3a8adb68d8bso2143877a91.1
 for <dev@dpdk.org>; Tue, 13 Oct 2026 08:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791904319;
 x=1792509119; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MlagJi5Cm84fTrANmweoMcrkNoGhFdbS7gApd9NU0qg=;
 b=HIVU/YPyq2sEvSaneMfnNflStnL6dlXj8msBh1Q3mN4ZIJXHT4bi2qwQDqfcXnslZj
 4sE9/nwnz/2kQZDSkDDd/C0tuqZmDupdoHyBjgup4mKuZz+zhADaSjlBlhV48muQUrFa
 Qis+UVQq0vvE+5FjspwnrcZN2foloAH5UrZBkPtUfmEUYGWVPP0dIglMuSVb73rfjt2h
 gq/4wJov4YJ/a0Qm7xPau6pc+8ey+MKqLM4HnZh9fnjdk82mW6K7hZg4dBQnhI+p2hWX
 oTw2Fdjsk3BJdy5WOo2CHqebfVYk3Tew8t4LidcGzmSOggeE2A+LTFfIZPdMW5RJf5wa
 0o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791904319; x=1792509119;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MlagJi5Cm84fTrANmweoMcrkNoGhFdbS7gApd9NU0qg=;
 b=YNalcVa5yW2gcZAG1ZH3c6eZR7S04mdUMCiXSbjjlhS3FXxBvjNypPuIjQ8cOQVaf0
 5xwufEodf5x8qoM4xzq6T599fXRn83/M6dF0DVYMCPih63b8LzRPHOe7kt0gwGVjxp9m
 MeS5zqottWLpxrlVoAI9rPF7kL+vEW94a9FTE2xHf9tCc7OPKk6Il50+kxDBklHms/T5
 iqHk4lrm39ARLvYTiJsX12OITanvgMypkv97nmN7AU1MFlrmTdZ7AI4hGQoCz1BA7nMH
 K/dTMBhI1trlQnOSZkiLF7wVVIP0F8JEiCRqDZvarpuqZmHY+pePWakZTO+HZpqk15Ga
 wrWA==
X-Gm-Message-State: AFq9FYKDrwaX69qmUofnCk6aj5vR76T58HF7ak3Q659VCbdPVCqF02/6
 AU7Ft/x+poqNILPAJRJqnZgmDtQ0jJ7hnN/B5elgWLE+605rPBq1XU7yzkD35Ysoavw=
X-Gm-Gg: AYBFou2ZmYSAC54MP0bOfVqFofLDSJA5rAjchv8beCzEnc5ocHasPy6dKLPFzdq1id+
 9Mf3iyy1GZcYvR/jYIG56zIP4C9t6lpER1oy53SQVYGrCYATaO6bE2FS8MjcMdiiWdw6o/lMNgP
 MBADIuRb8qFasuxhMohQpUpZ9EfBLGAv7/Qc7XYlzKCTjKGxQlNjkGz2h/2nsnWZH9thX2zes2T
 rskvn+ltVf0u5zWufBiFyxcJEJOeY7W0g0pkHOKO+bavsRWbEamYn+UeRxZ/EokZ4QZyG8QDG60
 nAl3Ja2Czjtb1EDGwcUArKFBo7pS9b4T2xqS1X4tyS4jEj7q9UaAcAD2nXBwraMqFAwyxju0WYz
 BjWHjxml4FkbICu1X4pVhLLWJtEvhgij9FJZ19tU8jtCkIYQR11UQaaJOilbX9v5YBEgECcJk+0
 zPtj2KF/izbhKn5IyGvfqitE39nVp39IvSDhmk8hOH8a0YY0leSxZX2YRV1WV26KGVQRvModnuZ
 bV9XxrLMVazD3a7OPb/CK/O/moLG1UfWQT/5/R3
X-Received: by 2002:a17:90b:534f:b0:3ab:2d17:51d8 with SMTP id
 98e67ed59e1d1-3ab3a99f162mr11251953a91.37.1791904319429; 
 Tue, 13 Oct 2026 08:11:59 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f05083fsm35116a91.1.2026.10.13.08.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:11:59 -0700 (PDT)
Date: Tue, 13 Oct 2026 07:55:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: Re: [PATCH v9-S2 05/13] net/dpaa2: support meter and policing
Message-ID: <20261013075516.7bb152b3@phoenix.local>
In-Reply-To: <20261012070444.2149617-6-prashant.gupta_3@nxp.com>
References: <20261009104900.1120550-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-1-prashant.gupta_3@nxp.com>
 <20261012070444.2149617-6-prashant.gupta_3@nxp.com>
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

On Mon, 12 Oct 2026 12:34:36 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> + * color_aware mode is not yet implemented: the firmware color input from
> + * FD[DROPP] is not read or acted upon.  Advertise only blind (non-aware)
> + * trTCM variants until color-aware handling is added.
> + */
> +static struct rte_mtr_capabilities s_dpaa2_mtr_capa = {
> +	.color_aware_trtcm_rfc2698_supported = false,
> +	.color_aware_trtcm_rfc4115_supported = false,
> +	.trtcm_rfc2698_byte_mode_supported = true,
> +	.trtcm_rfc2698_packet_mode_supported = true,
> +	.trtcm_rfc4115_byte_mode_supported = true,
> +	.trtcm_rfc4115_packet_mode_supported = true
> +};

Can this be constant?
