Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3E6C0219E
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C704402B9;
	Mon, 10 Feb 2025 19:24:04 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 65298402A4
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:02 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fa8ada664fso1420276a91.3
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211841;
 x=1739816641; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MfTxdzlhQIZtb0SC0p12u1z29vEtavcKk+47duriZ6w=;
 b=b+On4Ebb2E+dI7RR1D+TYOKgY+eYsBfkhyC8jzCpaNSZ2SaPn/pstelgGKfufTRUt1
 dDH85/u6iJcgRiHbwTA5YqubZewQ2sdKpBsXNGRXkBiDN0LTyE8HORee0hDOwSpzEkV1
 hTo99ZxXm1+CQypw064Zjj74AoNG9UGhVeBSthP4rCiwZCxSZeSSURUXO2ezTHbTq6vC
 UH6Fv7CxCqhtOeoc62JZNhF1m2OKTwq/G7URLARBh6BXg786bFSBQLVtkq8+VGJJ+yeb
 V6SQH+iQCPYQqIuFqYL34VreGaDMLF+3qnsGeluVT+5u0M0UAyIRfbTaf7SkvtRB3nqu
 saCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211841; x=1739816641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MfTxdzlhQIZtb0SC0p12u1z29vEtavcKk+47duriZ6w=;
 b=D0paGwlxIS3/pPC+HsFcU6pqtpxHOot3gXQ9T13lEaoH3Z2XL3nSbMie4R1kaloRNI
 Ap9mT7afSaljw1RzQ2Fk0N2f7hK6p1OSQnHb4LdV0qC0J8UNjbLkNsxOa5h9Kp516oNL
 5BgDhKzoPABcA1OKQCOZwtuOvd/3n9AGWKQJ/OQkh02mQa5y2ZYBM3AXmYnUl+c+33L1
 dxtrY7NdVreAt/bb4vF58ubpraZR77eXqbAwRj9xf2gO5Cymj2c/JQrKrYs7YJR8DXBJ
 E8WfFYsP5CQrOKmNC/EWoS9GGxiwduylAAtCML26F0j6ZLfKLxXasC0QIMxt0TEO1z3W
 73AA==
X-Gm-Message-State: AOJu0YyG7uMyGKQGxBFMsJ/6/cE3zZ9yCG40BS6b+gJYYMNqU32ow8uY
 1JYTTOtru1HlAEiWhBIHbvFmRyQ9h+nIEVMRcSkqIozoRklZqG1YlbN6jhrRGkw=
X-Gm-Gg: ASbGncstWfS8LqxxMeVZ6Q9AfAF+nImvxiTc9F94uV+yLZdbLz9PpVsOQSQBEnbPIDd
 RE4jcT5B9o1hNdOX+wJCbgVjQZBlMqKbNzAkx+HOWLniLFUJWcen+0CIh1l0WOOjM2XgF/IIMVt
 nHyk2W04cOZFEibY312dZjmA5umdIp8moWyjlEa/eL7XBFmoi0nijmDAT/0n1RrjCEVStH4Pg/k
 yoL7Fia4LDsLjHX2QOBNzsrAPV0y6NTylvYKhoC2DwbsB+HseLHYI5GWagHDkAgabnEiwUZaHua
 D687df1ZRVWLTcd1lHjLl1Ia+eX5MrI0l2Yx64/4LBvTDrLKe4nXeZhY30mozFiQDvyV
X-Google-Smtp-Source: AGHT+IGUlQc6JK0SVU2dd0oEhdjM4asb85PPOthILOQQ3CEkZNcg/Fv9lk0nYgeMZ5jRnIFkmuZX1w==
X-Received: by 2002:a17:90a:6fa1:b0:2f8:b2c:5ef3 with SMTP id
 98e67ed59e1d1-2fa24063babmr25782989a91.14.1739211841435; 
 Mon, 10 Feb 2025 10:24:01 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:00 -0800 (PST)
Date: Mon, 10 Feb 2025 09:33:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 05/14] net/zxdh: add tables dump address ops
Message-ID: <20250210093304.01103576@hermes.local>
In-Reply-To: <20250210014850.4105545-1-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210014850.4105545-1-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:48:50 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +
> +#define ZXDH_INIT_D_NODE(ptr, pdata) \
> +	do {\
> +		ZXDH_D_NODE *temp_ptr = ptr;\
> +		(temp_ptr)->data = pdata;\
> +		(temp_ptr)->prev = NULL;\
> +		(temp_ptr)->next = NULL;\
> +	} while (0)
> +
> +#define ZXDH_INIT_RBT_TN(p_tn, p_newkey) \
> +	do {\
> +		ZXDH_RB_TN *p_temp_tn = p_tn;\
> +		(p_temp_tn)->p_key    = p_newkey; \
> +		(p_temp_tn)->color_lsv = 0; \
> +		(p_temp_tn)->p_left   = NULL; \
> +		(p_temp_tn)->p_right  = NULL; \
> +		(p_temp_tn)->p_parent = NULL; \
> +		ZXDH_INIT_D_NODE(&((p_temp_tn)->tn_ln), (p_temp_tn));\
> +	} while (0)
> +
> +#define ZXDH_GET_TN_LSV(p_tn)   \
> +		((p_tn)->color_lsv >> 2)
> +
> +#define ZXDH_SET_TN_LSV(p_tn, list_val) \
> +	do {\
> +		ZXDH_RB_TN *p_temp_tn = p_tn;\
> +		(p_temp_tn)->color_lsv &= 0x3;\
> +		(p_temp_tn)->color_lsv |= ((list_val) << 2); \
> +	} while (0)
> +
> +#define ZXDH_SET_TN_COLOR(p_tn, color) \
> +	do {\
> +		ZXDH_RB_TN *p_temp_tn = p_tn;\
> +		(p_temp_tn)->color_lsv  &= 0xfffffffc;\
> +		(p_temp_tn)->color_lsv  |= ((color) & 0x3);\
> +	} while (0)
> +

Prefer using inline functions instead of macros.
That way you get type safety and everything is more readable.
