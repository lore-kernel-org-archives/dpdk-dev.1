Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A68BC0219B
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F28E640693;
	Mon, 10 Feb 2025 19:24:39 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 7419C4067D
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:38 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2fa1fb3c445so5637378a91.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211877;
 x=1739816677; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wp1qxqZZXAgqMWam5aW/cDDEMSbYkOOXv/91L3JRWVA=;
 b=kI1IbjDEOj4VCyiUb2o1x9CHxxiRRzKR9UILjLfx3gg36jgrMk6R1yFzTcuzOCXjws
 a6qCMT+WX/GEazt82UvwroYOMg3mknXgJstx3yF+1/Own1INsylV/uHp4yewfNknbo6o
 uJ4oe4N2vHF4B1Nmsu6iuAWDzoxDBvLyi9v0OmGn1Q3+rR45UaZpCwQsPjHJXmbZZXd8
 ACym4HSR6ZsJbulnftTKjm8Gqhu11CBP66ONei66J+SY3JAaGxCOigRddETLwuCJyDW/
 aA6O58IymdT/eJtBtBAE8of+v0/4DIJpMkzPmIGh8IlPkLn9v78e846yC2fB3JzP+AAf
 14LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211877; x=1739816677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wp1qxqZZXAgqMWam5aW/cDDEMSbYkOOXv/91L3JRWVA=;
 b=nHxAvOjqtUHSmnLzD4Nt5XdnGhWT5/qmNR7VFVvYY6jZrPWw7AVVoF1/KunqQSFk14
 9UDUiVwj5K7dZXxXhuswyw2mr3GmUpaQOQUfxakhigyvbN1qqiWdYzAeQaMz42DmEWqx
 3cv4n237TBJ9i00gUxB+fanVXTzAPflrM5DtYezBXf0ZS1Uj70vXaqolx3/i6iv2nSgk
 C+CUZEDesQr3wC9L8I9sOUbwKf8BxB+oVXVXg11td0GrYwIDbQ51FYMtneoksX6Q6czS
 ET3TQIgUUFLIh4XooNGpNjlHD4/AYtCHazoxsh+RYKKN3rluK5M60O92RymBNhXhP40O
 v57A==
X-Gm-Message-State: AOJu0YzxPxN19QLLdwa1sifIpPN85CLARR84cb4hfEw5Zpm2YJ3cBGxF
 78uU4r1kN8DPhlO4qXdwHQ1BjxK4Rypn7QGQHrSh+6rF54fjsPPtIe2gud2PohFF03ETWwvePQ3
 5
X-Gm-Gg: ASbGnctlRJcgmhAeiiz+tvDm0MYQCt/U2EhCaSmrBdIo/TvOgIlOo3emkr9a7tc3vBO
 J/MiTuaPa1GlHRVimq9ikzLNluRJpcAncg5aCl2UwGWYhBvpO8HkZVfki2w+QzRB4h960IG4cOq
 6YctB8i1vul0kYC60RSYlZUFjeealNnYyf+ucFqo7bx+Q1Q2hOCMBINxYDcInEZERJe2W6qAmvH
 jCiZ6dEhzR1npJg3qnOkWExjv+izfyLPGXNOkAgwd+P4hzo9T+eJM/NMkqp3qHRHc/qZMQ4wb9R
 AqawhTUM6a2aHOd1+4HYgKvvZ5+dPjB5jgGtV1+SkDKqlVrnBHFVY0hlva1yi5xmfauX
X-Google-Smtp-Source: AGHT+IHYDTf+tEaBryWd8/eeqfwaYf5kN2F4D5DsYXC4zSAmWyWnTcGXejM7tokFTOIjLWabSorBJw==
X-Received: by 2002:a17:90a:d643:b0:2fa:20f4:d27f with SMTP id
 98e67ed59e1d1-2fa9ee31752mr648426a91.32.1739211877627; 
 Mon, 10 Feb 2025 10:24:37 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:37 -0800 (PST)
Date: Mon, 10 Feb 2025 09:50:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 14/14] net/zxdh: clean stat values
Message-ID: <20250210095005.404922ea@hermes.local>
In-Reply-To: <20250210015017.4105624-9-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-9-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:17 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +
> +		case ZXDH_ERAM128_OPR_64b:
> +		{
> +			if ((base_addr + (index >> 1)) > ZXDH_SE_SMMU0_ERAM_ADDR_NUM_TOTAL - 1) {
> +				PMD_DRV_LOG(ERR, "%s : index out of range !", __func__);
> +				rc = zxdh_np_comm_mutex_unlock(p_ind_mutex);
> +				ZXDH_COMM_CHECK_DEV_RC(dev_id, rc, "zxdh_np_comm_mutex_unlock");
> +				return ZXDH_ERR;
> +			}
> +
> +			row_index = (index << 6) & ZXDH_ERAM128_BADDR_MASK;
> +			col_index = index & 0x1;
> +			break;
> +		}

More repeats of __func__ with PMD_DRV_LOG and extra { }
