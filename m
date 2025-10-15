Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A0ECCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:10:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 131AC40E25;
	Thu, 16 Oct 2025 00:10:44 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 035D440E03
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:10:43 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-87c148fb575so602836d6.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566242;
 x=1761171042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vmlOEhQb8UjLSBM08LPZ0ufWbXAO5JxS4lvqisLxg8=;
 b=Df/WEJNtHDPGUuLoNc9Y70F4cfCvTPCVMj42JGNUTMyNhvz+aQB6SEzp1r0ryhh/Ap
 4cVS1ZkaDRqoZzXHS0XS2JdhuR+w9omd+E/YCBrBeMM4U/zIZpDUWtDxNqTLpDNFv0sB
 CH3AtGc68N25VpyGX+Vt3Lt4Oo+l85EDzMg3ryQx7BlYdY661XyUIfiksAlf5yveyp6P
 IIAkblyVJ0++3ist4kB+6ajxVAEnOhplUfYJTMrrVBwFS2KUr/ldyt9PJJgxFFC27yAU
 T8Cgm+70JZsh9OWBvskzzGJEH2NliVuxZwrYc/3P38yeLnLX4KpazhB2ukYp7SkTwnPc
 rA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566242; x=1761171042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vmlOEhQb8UjLSBM08LPZ0ufWbXAO5JxS4lvqisLxg8=;
 b=goKRzNYO3j8CKYR3uJW7rgwzK0U1ubsu5DBLYIKHSfuAVI00aJ5sqxrq8zG/lpQHhQ
 ZV62B1oOoBQgWdUZ4VfWmJeA+u0hfG/9FGa3yymM/9Z6SwrTs/VZlIc/T2p43TMZ4bP/
 JZ1tQJ/nMcJQ6yqvd0paR92DxS3WLnZtE3FdJY4JCvsB6Z+8KLfVLMKc1dzpv0JV0ME5
 cGh8YUwBvWX4JDmO09+xsU8Ag5amnqJJWCJ2qxINwSEZLH7oWyyt8C1dmq4gxI5VCAmN
 acS9Z6skynAQ8bJ2EV0osxdhKutO02naQLY7XrNT3iw13NLO6ZyLP6grN8kHqDGI1f3/
 Qo/w==
X-Gm-Message-State: AOJu0YypKw1M5DsJkJBKAR4zeWDv6y+sQFAPgvTyPkhluoTa4I7nBicq
 HwwyarAKcb1F6CthrOSa1vAcDbabEswWYoFOigOTcvyHYfUwLBr2o13RJXZgOgj/Gj0=
X-Gm-Gg: ASbGnctI17PWEWQu6YEi5BnrG0qlG8Ja3f0kaTzv9c6YqSPu8TNQhbyVfcCYWtZ+bJK
 PaCNk7W8aplVizgVmgdqllET2Kfjc58UKUTvzOdWRuuFTKdX7AQdQMV2CODNs56OHp6tiPHQ+7s
 PE8PgbXW9haOjK82+DMz471Qg8x/lhbO1BVBiD/aYvG0v9VMW5trfYjUalWbO3S0Upu9854bpE/
 8BrbUA6LPxjx1lSo8vFSGbf9diOVd3J11lFCxpcvTCe8jTf85g1fHoXbJb+lb7foGJYv0sqcl1T
 rk///8NnjqAkO8MpnBa2hN62B6ZdSDi9OkqoS4p/87Pt3cbn5F/un8VElHzzCPMENEBJ+V2i7px
 dVpiK59Ai5GrEafok+1MfTxJiOL+f7jUsDvavteAat50ofsviAALLi5FxC1CAF3gks43GZKGUQr
 0if7GXHyE8zpmSNdP41RsL5PE1t2I78wbp7jO3AYqXZTJhClGgBuIy
X-Google-Smtp-Source: AGHT+IHRo78tlzPOEPB4MEBPhEumI78//HtLbfjpeASo6EVTKGhvPzhhBO4WMMmpZstGWOs9S3qNyA==
X-Received: by 2002:ac8:7f81:0:b0:4b7:ad88:45f9 with SMTP id
 d75a77b69052e-4e6eacdfa65mr391112801cf.7.1760566242172; 
 Wed, 15 Oct 2025 15:10:42 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c577e6sm27732021cf.7.2025.10.15.15.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:10:42 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:43:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: Re: [v1 02/12] net/enetc: Add RX and TX queue APIs for ENETC4 PMD
Message-ID: <20251015144357.36156f93@hermes.local>
In-Reply-To: <20251009111633.3585957-3-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251009111633.3585957-3-vanshika.shukla@nxp.com>
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

On Thu,  9 Oct 2025 16:46:23 +0530
vanshika.shukla@nxp.com wrote:

> @@ -190,6 +583,14 @@ static const struct eth_dev_ops enetc4_ops = {
>  	.dev_stop             = enetc4_dev_stop,
>  	.dev_close            = enetc4_dev_close,
>  	.dev_infos_get        = enetc4_dev_infos_get,
> +	.rx_queue_setup       = enetc4_rx_queue_setup,
> +	.rx_queue_start       = enetc4_rx_queue_start,
> +	.rx_queue_stop        = enetc4_rx_queue_stop,
> +	.rx_queue_release     = enetc4_rx_queue_release,
> +	.tx_queue_setup       = enetc4_tx_queue_setup,
> +	.tx_queue_start       = enetc4_tx_queue_start,
> +	.tx_queue_stop        = enetc4_tx_queue_stop,
> +	.tx_queue_release     = enetc4_tx_queue_release,
>  };

Would be helpful if driver supported rxq_info_get and txq_info_get.

