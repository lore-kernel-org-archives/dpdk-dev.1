Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B6CC02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:25:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 549AC4066D;
	Mon, 10 Feb 2025 19:24:54 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0C94340687
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:53 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-21f573ff39bso64435855ad.1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211892;
 x=1739816692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1DXUgRKAd+VjvZN3rIry2TZYGKs2GwN8yIEg5Bi0Ow=;
 b=Y5D2QWWGNXZgI00Mco2Bh9GRvo4JX6KngyhGEHrQJpHnV2OCiknQ/OaN+LtZIgo71r
 Y7520nuIeJAW5nP77GM861kGQGacs6S6U9gNh2hksnofnOTWd4E3JNxlTtNArs4uWeT2
 PyVqS9Bx426UkmEbySCzuo1d462uDcY0N7W4l32PObx/JCnCt4Nywp7xhZNOpK0ZgWo5
 AZoZdEeIfNkHELefBBhqLn04pv8ftEvo03XCoEvmQNmD+W91CdlHE8owIM/670tmHVmO
 jc7uYeI6vBqeXxIqpfmudW/TRjL3HA9lp04gcgSKeX1ubM17weGJxl/W/G16otCYVLT/
 QzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211892; x=1739816692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1DXUgRKAd+VjvZN3rIry2TZYGKs2GwN8yIEg5Bi0Ow=;
 b=KGMjIp6R9F5uztd4Puw3nJxvKnDNyHNMoHqUB099viXoaYYUxjYgHQ7xFL5VvZvVr0
 bYv86FOpZXQ3niQC7NqTY6+twbwqIiudtuhnSlLY21usJPiObhBoM7odZUUPBGktj529
 F0hPzX80TLojvPmTQsI81Fv9L+P8O6Lv82n2/7Pkgs3A8qD/ic/rkw7fbxmoS23SYGrK
 hmyIFmClsnJFloQUS7dCAlgN34I/TvFPDkLHGu84YylWEpEu6tI9S5sTmGHrUu0ED8gf
 V9e8wKyPUmVcqANG6hiD3KQ6OEWoCxAnr1IjTFsGy3FnT/mG3I7rFjRAvMEppueYTo3E
 /Ljg==
X-Gm-Message-State: AOJu0YzA9VROUJk+2oaJt7PatyYhsg/etTxOUIm+K4HMakQPK8Aq2uaE
 IdftVzMFLR24FCcDYaS7EgVyNfq6yTt+KnXUfujr+xMrcevAN+hMzFXDZ2aropw+y9bb6wDSEgT
 s
X-Gm-Gg: ASbGnctdmmqaPgVpykPrb+uTxrPYredJTYNZyos1D07O+MvYRh/M88SOKRCygzmyWcE
 spBpVDx1f6gN7F+NTuV9Q0qnQfqYYHRz+yRWtod8vCgKRAQfCC+Ydlws7T0EQFEr9r8Y4JY5VSC
 oTpONlNrevn6JYtq9duN+9cUcHkDDFC+L+2UrX2JiShwfGjK3EKYxi4hxjnMdCR1Tp8wNOOV1O5
 YsfPz7Rd9MF+SPGWxCL8aj4DkPVxIFloE0kGNGkvvW6FtXGzXMBf1XpblagZd2+bQeDPH/BhhCW
 5qGCzyb/ey4GFMSwVwMGmbF4UlND8hta5/Wf7REYbhwvQadHWElzyrPuBqyN0yEhczSm
X-Google-Smtp-Source: AGHT+IGX2xP3MzIxyCNTs0THgF5IBPBzc4U7Kd6faihzLLE5u2lJiSX7CoiRSFGkvEvSWduKgr7zKQ==
X-Received: by 2002:a17:903:240f:b0:216:7cde:523 with SMTP id
 d9443c01a7336-21f4e739f99mr259923395ad.32.1739211892179; 
 Mon, 10 Feb 2025 10:24:52 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:51 -0800 (PST)
Date: Mon, 10 Feb 2025 09:47:26 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 12/14] net/zxdh: delete all hash entries
Message-ID: <20250210094726.128af4b6@hermes.local>
In-Reply-To: <20250210015017.4105624-7-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-7-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:15 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +#define ZXDH_COMM_CHECK_POINT_MEMORY_FREE2PTR(point, ptr0, ptr1)\
> +do {\
> +	if ((point) == NULL) {\
> +		PMD_DRV_LOG(ERR, " ZXDH %s:%d[Error:POINT NULL] ! FUNCTION"\
> +		": %s!", __FILE__, __LINE__, __func__);\
> +		rte_free(ptr0);\
> +		rte_free(ptr1);\
> +		RTE_ASSERT(0);\

Again, PMD_DRV_LOG already puts function name in, and making louder
by SCREAMING UPPER CASE won't fix the problem
