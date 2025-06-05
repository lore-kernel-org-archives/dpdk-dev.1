Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFD8C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 15:22:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82E3F40270;
	Thu,  5 Jun 2025 17:22:51 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id E9F8840150
 for <dev@dpdk.org>; Thu,  5 Jun 2025 17:22:50 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4a585dc5f4aso13237431cf.2
 for <dev@dpdk.org>; Thu, 05 Jun 2025 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749136970;
 x=1749741770; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JUaSvngxp0SPwZBJo4ih6WUu/NQFU5z8pafAD80+2k=;
 b=02MW1605TGk6Jl+Zd3dkM/S5OEEgUkd7XS4SLPHyqPkvpa/yLjHOn22+cq5NzZEjKx
 /SWO8fj97G8hF6Vm+Ke5cIQAbb5bjfByCQBELlNqZFLz6AWWy67OZCfubYg8sUH530+/
 UKep8OgGW+9Av3iP7eoajtDrGKR5HLD0hkeJyLhm7+TCCylkPJxkYI5S1pKybkAYKqmt
 xaITGmoqSPUjeLRNIbuqBrbCTQhY2GbBWV1g/qN5o3bwD7RFV4VzJ9nfou64jUOjPjQ4
 EYR/Cq9y4EHXLlo+fRfCFFo/6AYru1kj/Q50NMb2fVFkXIor48vegyCunFD0NYfMQevz
 BtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749136970; x=1749741770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JUaSvngxp0SPwZBJo4ih6WUu/NQFU5z8pafAD80+2k=;
 b=lvxIcPbv7+t/JDwBBkd9T2r/hOLOVUdGhiXmOv4rBLGcV/XZiMiYheHTI0aOPsZE09
 ONuq7P/JRzr7nGneo3r/OvnGNs5ooe8RcudPE/aLggmefygigRGQxCn8Y0zm6qroNnQu
 sxeRJZwHHJcS/B+2yUMAfNzmY5vF8n187sYZBWu+ucWMu+N624V+mJKUMqc6XfZU07Dw
 Gx5oiN/lRqgOSE4LxqW4rDz9ThkzeMolW01pLeY0CQ3bBQqc6eBKFDgjy1dxlEDaPiO+
 a0az6mckKGy/V2ZV4w/hAxZllTuLXVs6WuveSnjJazQFm0Q0gTB/39Ep9lpkPSNaHvSr
 tXUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXjyg5nnaf/fUC1OWZfBwecyhnUcB27k4O7R0DMtjn3ZQopqc5FGH768EncxHn1vnWFmU=@dpdk.org
X-Gm-Message-State: AOJu0YxiKMf+PJb1Dp28YUj4dKgi75gisEVXLmrP9vrwVzjshDfRBu5t
 3fcs72kO3Hw8zDrQBE8z0mjYLNmG1iMuOuXRQQvJBXbARlS/BtQsmb9lmmpI/9EQuZ4=
X-Gm-Gg: ASbGnctqaSjcvN4787MMnDByxExOiYyuR7wlzLrBjJSEERLGmuX85P8v/SuOFiQiDj0
 AZQvxm9MO81oFg3Bg9f8sEShJ93A9Qs7/r+m3V8lMhmYB5HQeVAfoyq73ijf+tdQJU0f0yK97Ql
 dRFwOVivKmizhTri6lt2uJDl/yzEkqExDZn/DC6q8FkvI13IGElfh6OuAqDtzb19g9P1J1X7VDg
 yulM+3EiBAEBbdJ2RSuptr/wk9bvdFP7Vyjh4ZJ5aKeRCL8nzJJi3T0HvX3M4jh0Q/F2Nzx4pIO
 0YQThgYYMi0DJNa2ApaLFrMC59oRaiwy33OQ7NhYcdMpARDEqV+LfZvd2fnv1SgjPa/reOlCr49
 7tjL0c+/TR7iUogYtXPGsVP86L64bhCrV02waotU=
X-Google-Smtp-Source: AGHT+IHn9W378I+6T3fKPC4+rBJdmlmo54lpGrkImpyTs1NKdsOu2XmqMFaScae3st6xVBptFxteYA==
X-Received: by 2002:a05:620a:248a:b0:7c5:95e6:ce1d with SMTP id
 af79cd13be357-7d2297870abmr5990485a.0.1749136970075; 
 Thu, 05 Jun 2025 08:22:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d09a0e5c3asm1253053385a.22.2025.06.05.08.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 08:22:49 -0700 (PDT)
Date: Thu, 5 Jun 2025 08:22:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>
Subject: Re: [PATCH 1/7] ethdev: add support to provide link type
Message-ID: <20250605082246.3f13eac2@hermes.local>
In-Reply-To: <20250605090657.3032918-1-skori@marvell.com>
References: <20250605090657.3032918-1-skori@marvell.com>
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

On Thu, 5 Jun 2025 14:36:36 +0530
<skori@marvell.com> wrote:

> @@ -341,6 +354,7 @@ struct rte_eth_link {
>  			uint16_t link_duplex  : 1;  /**< RTE_ETH_LINK_[HALF/FULL]_DUPLEX */
>  			uint16_t link_autoneg : 1;  /**< RTE_ETH_LINK_[AUTONEG/FIXED] */
>  			uint16_t link_status  : 1;  /**< RTE_ETH_LINK_[DOWN/UP] */
> +			uint16_t link_type    : 5;  /**< RTE_ETH_LINK_TYPE_XXX */
>  		};
>  	};
>  };

ABI change will have to wait for 25.11
