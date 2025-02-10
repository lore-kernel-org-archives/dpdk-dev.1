Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D6C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 18:24:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 670704066C;
	Mon, 10 Feb 2025 19:24:37 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id C751A4067A
 for <dev@dpdk.org>; Mon, 10 Feb 2025 19:24:35 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2fa286ea7e8so4906683a91.2
 for <dev@dpdk.org>; Mon, 10 Feb 2025 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739211875;
 x=1739816675; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vb5I3W04Y7hluYU4ODPCr9c/j436FYf4/WBx4kyuMk=;
 b=l/T275DyHpfheCa8kMdQMioADq6q9XjgdI4l9fVllcGllEd4SKRFZK81btl0Zrf4sG
 Fls17oY7NHgvm3Ua5BUEHy4A7lH+fXJAcnszURjV7//jVPZKxWwjxnU+rmP5UCrfpXnz
 gqq5C8U07aF520T6MRZNcKx02tKXf7HqvuUimxhvryZoeWrwpsKkzV7hwZSEuNoZaCU2
 DSoq8DEMpqNFy3lq8JRiuYyKGlHAu6Z4wSH+YqRYfPotqmrQ9fHN9w2tp9wFh/gUhZ8H
 QR3/QnnVVdLUdY3Ot1etDxSSffasHsj02Pnk84uXhBmXLQaroDaWktkEK7lgaIF2cfne
 NhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211875; x=1739816675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vb5I3W04Y7hluYU4ODPCr9c/j436FYf4/WBx4kyuMk=;
 b=igFzqlz0L93pGtxUUan2GukXkJCfhXXJK/o09gvqcsboKE7Y4J7isXWwKy/vgRaLLo
 eKtom0NKk0rv5uJ+MUgBXYqhZ8dkxDhtXVPAU28wdKeugBt41OCaaWUQSW4sbc57f9ek
 RDEmXq9kskqV2QbssygYONd4Lp5S/gWqj/Bw/o5s5ztqlF34UfsDZo9P+Q5FInsWnvLu
 uyBCvHp+f0S7F6n1MY8917IB2zExKaBBCeNNsJD3wJ9nqSnYyTTVLHU0abTfLYYBQG54
 tEF4JRzHm5C2fHM2M6buAihRWbhG8kspEXrPkW8AWpeaQ76iD52z1Dgc8Zc8t+Xf5Rkw
 96Pw==
X-Gm-Message-State: AOJu0YwuzO7+kf6mAcLlkQziSUsWhYJtyNUmInlSLhJxrVnQvAx0/5f5
 QJWB5ANPJxRMlY4PQkH2Lrgdy0/iWhJiF5gGQ1/szvC9RKneYQAQ5v0IVN8FZvTez0AhB375RPV
 a
X-Gm-Gg: ASbGncsys8+B7SvuvhRnFqK84t0jGRSeyZokW9cVMZksGPc+uruaVLMLj6WM0Q9qCtp
 /A7J52bcv0jIKnJRKa0uaXMxgtiHhobPnCYG825pecCKepRQr25ti0jfstAJW7+bjckykhX/QTr
 LkY1AmVxA4PExyAtLdSpMATrEZ0mwDW2UHxp0vZ1+1Jl2WV3JlpxNSQTK6Fm92/wu+i005bFv10
 CkpUool3jirVPm/qoEdWmzPZc1WMuzC8Kq8y/hODKhCfbju0RgCAacQJQ2lbSZ+DL2zvNV9p1Hi
 zJ8o1yGJ9wf0+58iFCXQdUYuv1e6MBk+j6zUJd9mzLapfINF8chpcWmWAslQyc04sj5e
X-Google-Smtp-Source: AGHT+IFCoNKoQbnruU497+4TLfMyuU5Pt9iMqkq2mSbhdnD1nnYyLrPF+cahcFYqmcy8mjxVXnwR0A==
X-Received: by 2002:a17:90b:3d03:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-2fa23f42672mr23162951a91.2.1739211874959; 
 Mon, 10 Feb 2025 10:24:34 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa42dde5e5sm5519217a91.3.2025.02.10.10.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 10:24:34 -0800 (PST)
Date: Mon, 10 Feb 2025 09:46:04 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bingbin Chen <chen.bingbin@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 11/14] net/zxdh: get hash table entry result
Message-ID: <20250210094604.2571bf4c@hermes.local>
In-Reply-To: <20250210015017.4105624-6-chen.bingbin@zte.com.cn>
References: <20250210014441.4105335-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-1-chen.bingbin@zte.com.cn>
 <20250210015017.4105624-6-chen.bingbin@zte.com.cn>
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

On Mon, 10 Feb 2025 09:50:14 +0800
Bingbin Chen <chen.bingbin@zte.com.cn> wrote:

> +static uint32_t
> +zxdh_np_dtb_zcam_dump_info_write(uint32_t dev_id,
> +							uint32_t addr,
> +							uint32_t tb_width,
> +							uint32_t depth,
> +							uint32_t addr_high32,
> +							uint32_t addr_low32,
> +							uint32_t *p_dump_info)
> +{
> +	uint32_t rc = ZXDH_OK;
> +
> +	ZXDH_DTB_ZCAM_DUMP_FORM_T dtb_zcam_dump_form_info = {0};
> +
> +	dtb_zcam_dump_form_info.valid = 1;
> +	dtb_zcam_dump_form_info.up_type = ZXDH_DTB_DUMP_MODE_ZCAM;
> +	dtb_zcam_dump_form_info.tb_width = tb_width;
> +	dtb_zcam_dump_form_info.sram_addr = addr & 0x1FF;
> +	dtb_zcam_dump_form_info.ram_reg_flag = (addr >> 16) & 0x1;
> +	dtb_zcam_dump_form_info.z_reg_cell_id = (addr >> 9) & 0x3;
> +	dtb_zcam_dump_form_info.zblock_id = (addr >> 11) & 0x7;
> +	dtb_zcam_dump_form_info.zgroup_id = (addr >> 14) & 0x3;
> +	dtb_zcam_dump_form_info.tb_depth = depth;
> +	dtb_zcam_dump_form_info.tb_dst_addr_h = addr_high32;
> +	dtb_zcam_dump_form_info.tb_dst_addr_l = addr_low32;
> +

Looks like structure initializer here.
