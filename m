Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64591CAC592
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Sep 2025 18:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB5A94042F;
	Mon, 15 Sep 2025 20:05:16 +0200 (CEST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41]) by mails.dpdk.org (Postfix) with ESMTP id 583D7402C2
 for <dev@dpdk.org>; Mon, 15 Sep 2025 20:05:15 +0200 (CEST)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b0415e03e25so579124266b.0
 for <dev@dpdk.org>; Mon, 15 Sep 2025 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757959515;
 x=1758564315; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IBSZDlLLwsCCbbJDt7wApay1EMKpFTAQLQ+2T0jVXE=;
 b=iDQ8Rzjv/bPcaaA0ZoxkeC5q6YzK6nQLyDfr0RB4xi6Ajxkar9vG++XnRpX8JH9bzZ
 hkiFvjqaqd51V8EGYOsWF9zKO2is0FhoNLa+rcM4y8jsHe1cmOqx0TTuF0/23IP0CxY8
 ao/EvX5f1QD989M3Mgdn2XgYCJ6F+Z3/DPC+nMNzW27Rtdc5XDygq1fnNn40f1zmnDbu
 ja/PCHe8LtI2iVu4ZK76SBnBzFYpRDxZm8Yp1AlGIfzNPjKio4l+iTVcYO4jFtrIuZLT
 GVq149QKZ+9KhoxHAtqk2GgPa9kx4nMv9lx4WFdGp0chPmx/X3bqwvHKrQ5riQ1T0bZK
 iv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757959515; x=1758564315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IBSZDlLLwsCCbbJDt7wApay1EMKpFTAQLQ+2T0jVXE=;
 b=EAXP9HxvJmMk+e97vnAS2xjI3h+h3+jjgDXQvy0bt/g2hZ7sOsjEkgYCrRZQsEpa6R
 pGhVOirrDMjjjJbUHduQzKpM7H5+xhga2KaT4GtGgqfnbbm8c32sOORcil2f9IeDr46n
 BJdf/twbNdvXcDggM13mkMF9w0rZbJm+b6iDABTjZEjnQwpubVwoo1iPvD3CK+BmQKNl
 0CioI54WarMSeJWvjY2jmufD2/DOY8VuOVtm1kmKWDUbGCPCg2HSpOgU/LA7uQnujiE5
 tHAzriQ80aOrndEo3r9UVfs9bJVKx49GFAPyhh+EoEjd60AhyrRmVbCMs9fPiVUlaZte
 7ogA==
X-Gm-Message-State: AOJu0YxsxElivuDEXGviBRQcteAV2V+WWkCla9LXFwvrQp1uQGXZ2CNi
 EGUjrtZdiM75V2mKQubZVdzv9yAAq3V0+y0B8H+nDAtPjQTe9s2Zrlj0l5eghnUWRkM=
X-Gm-Gg: ASbGncuTQmve4T4yvtjt26dilOgqB4vSGKP49dowSfVhbTCbz2z/JcGSmmT8aLwjeNx
 NScOJiZI2gCszQEZCcEno2WjPic/+bSCJsjUTTiO3paijHbQf/ByJEsyVM7tcmxz1GECnyHm9Vv
 m0S9F0Pi+o53rzu7RvUn9Vi7jr57SshomGnxt92DydLxzapofrDhM2s6kFCArQgCnfJrIV00hGN
 GSMy+vanx+1acTLCpvh7TSavAg3okfLbyHVLv9/9op0TeiJT6De9SkYiCx+9tk+/QW83SPNyBUv
 Ik4RvYbd1KuM7+9u8/xsIw47/dBYnKfdaq8UrF1vmcBupwnbKqABKP4UDLMoqYSTr2l0l/SQ239
 coPIuwIDVJrwLQAktGTB0TTPprlsJmNG6+lO5Zn6wbtGWEXzsds+qEQ1tiCOzpU5gx0f2FyEs0c
 U=
X-Google-Smtp-Source: AGHT+IF5DyjvaFdTRPcz+OacJnsZyDm7OQCGvebuuOMoyoHxbBrJKBPWoWpqRUguljlvuExMGz2AYw==
X-Received: by 2002:a17:907:3fa1:b0:b07:88aa:255b with SMTP id
 a640c23a62f3a-b07c354ed12mr1287356466b.11.1757959514787; 
 Mon, 15 Sep 2025 11:05:14 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62f2648afb1sm4180467a12.29.2025.09.15.11.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 11:05:14 -0700 (PDT)
Date: Mon, 15 Sep 2025 11:05:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Alexander Kozyrev <akozyrev@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, <rasland@nvidia.com>,
 <bingz@nvidia.com>, <orika@nvidia.com>
Subject: Re: [PATCH] app/testpmd: use table ID for jump to matcher action
Message-ID: <20250915110508.7a1413bd@hermes.local>
In-Reply-To: <20250819144508.722653-1-akozyrev@nvidia.com>
References: <20250819144508.722653-1-akozyrev@nvidia.com>
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

On Tue, 19 Aug 2025 17:45:05 +0300
Alexander Kozyrev <akozyrev@nvidia.com> wrote:

> +/** Parse table id and convert to table pointer for jump_to_table_index action. */
> +static int
> +parse_jump_table_id(struct context *ctx, const struct token *token,
> +		    const char *str, unsigned int len,
> +		    void *buf, unsigned int size)
> +{
> +	struct buffer *out = buf;
> +	struct rte_port *port;
> +	struct port_table *pt;
> +	uint32_t table_id;
> +	const struct arg *arg;
> +	void *entry_ptr;
> +
> +	/* Get the arg before parse_int consumes it */
> +	arg = pop_args(ctx);
> +	if (!arg)
> +		return -1;
> +	/* Push it back and do the standard integer parsing */
> +	if (push_args(ctx, arg) < 0)
> +		return -1;
> +	if (parse_int(ctx, token, str, len, buf, size) < 0)
> +		return -1;
> +	/* Nothing else to do if there is no buffer */
> +	if (!out || !ctx->object)
> +		return len;
> +	/* Get the parsed table ID from where parse_int stored it */
> +	entry_ptr = (uint8_t *)ctx->object + arg->offset;
> +	table_id = *(uint32_t *)entry_ptr;

This creates a possibly unaligned memory access. Is that OK?

Other code in cmdline_flow.c like parse_action is using memcpy
to avoid this.



