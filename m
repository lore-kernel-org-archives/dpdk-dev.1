Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FD8C36008
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Mar 2025 14:19:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86CBF4064E;
	Wed, 26 Mar 2025 15:19:05 +0100 (CET)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id A309E402E0
 for <dev@dpdk.org>; Wed, 26 Mar 2025 15:19:04 +0100 (CET)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso8396456a91.2
 for <dev@dpdk.org>; Wed, 26 Mar 2025 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742998744;
 x=1743603544; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KbpwbYRA9a/QctFR6ZLhRf3FelU6Es3eJvlHLMfhJyk=;
 b=0VPKOLippeunQwWZSSmRrGT+kYdgXs4wqiuK874Mb1WYoMm0ayqjlvqqZqBJDL33ES
 hxefenm9+pP4bKIqjiAkk6klIAVqoVMZFE+LX6DQ98J01xpQD2TCw3VNVgqEp974Jljp
 9ctfGdNpj6d7rLYWLD7wqeHvjuKyiuyDyxxjXihVjPeoLORlo/cHgDEKDjFVDgeAs/HE
 391M9arf9UWGb4ApB4eOqiHFL5vTDkDba1JaIKTVONganv6qmb9DMFo9iRrvJyOqtSW0
 1XgvvmudXTP/JhLatKcgK3ke/+92eRUPBsCUFWiyAboT1IMNWVU988eEtSSrf1W2wmTa
 mOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742998744; x=1743603544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbpwbYRA9a/QctFR6ZLhRf3FelU6Es3eJvlHLMfhJyk=;
 b=CIwXq/HP/o5z3BAxUWp1iXqYu7bI6D0iz9fz7baeFQuHqCkEB2BLH2kXKMQCChU2PF
 dMiOwIf+aiMJL0nNB6qfp0CyPZmzplcZ4aVO6z9CAEIn+gXiL8eZrmhon7hIrJ/XcNcU
 89YZyz/6zi4ie70stFaXs+HsG27FZORKGy7hDLNieHsTN572lOiZF8/L6/2kY3nzP+ZW
 jWKDz6WOzp4lVPQdWQcr4Ujg2YwSOyW3jfOf6VFSc7B1KgpCOLqdisWqd94KWirIZXYY
 WLyleK1GwuzHXa3o6JP+GYhcOGb/TSh+P0P/hrLWIub61/jhi/kRC7IFjQXPCU4O4Izq
 LC5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2nOCySO2CRrR8PYa53IHAK8ObuLKgOmx4VL9Ih7iYQwlBv0NuOH3DGLlC2aRuhrDJ0Cg=@dpdk.org
X-Gm-Message-State: AOJu0YwuXTzbpl0vwCsc6XGNoPseMHTLveQ7xEjKkhm8GXhLCzT8StqZ
 06yCDg2HxznnLsaB6wVS4qr3jTwoLdhAPdqCbGLsE1wwevrH4x4s2GafPFvP1PI=
X-Gm-Gg: ASbGncslAKhC7fBix8+xcRQRey7c5zXm0eVkqd7n9YJAg7DiUqBq9QjRzKJmPBSfw50
 Dvd/pXSd+f3ib5l4wlF2Qu28a5ymBnf8KqTQv5OHnYcZY6V1/R+L2WhLmHo7/3pZN75VNMejAES
 l+aeFcqf13H2qCN6qAa6ncvXwPKyGuNNUeuDFkHVOkyswv9f0mf/cdfsVR/4NXZ6eAnTrfzzjfy
 8WwBeDAVG/LT9YLaPw/H8Y16VD16xMw3wGE7tVWmuUooVTRagdJADJXRmXbRtzlxJXoN1XgUt1L
 SnzM6WmxVQGxXKaDkujCPnc1bSGy2AZla6ZxZY3cOiADvi08PEiK48qe0jMu2r7IBh4pvIsvFa8
 MNDN0wqLoXJd82xCIeU1z
X-Google-Smtp-Source: AGHT+IGDTzxUU/Zbys30QfbtYsJ8NIs9Udy1cfJzysgXit9woaG5RyYHmH89WcSJm7Ig6ShDSng3BQ==
X-Received: by 2002:a05:6a21:a92:b0:1f5:6a1a:329b with SMTP id
 adf61e73a8af0-1fe4300f787mr42757683637.32.1742998743589; 
 Wed, 26 Mar 2025 07:19:03 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a23dc8e4sm11075315a12.0.2025.03.26.07.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 07:19:03 -0700 (PDT)
Date: Wed, 26 Mar 2025 07:18:57 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <pbhagavatula@marvell.com>
Cc: <jerinj@marvell.com>, <dev@dpdk.org>
Subject: Re: [RFC 2/2] eventdev: add default software vector adapter
Message-ID: <20250326071857.7ef4a050@hermes.local>
In-Reply-To: <20250326131441.5965-3-pbhagavatula@marvell.com>
References: <20250326131441.5965-1-pbhagavatula@marvell.com>
 <20250326131441.5965-3-pbhagavatula@marvell.com>
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

On Wed, 26 Mar 2025 18:44:36 +0530
<pbhagavatula@marvell.com> wrote:

> +struct sw_vector_adapter_service_data {
> +	uint32_t service_id;
> +	RTE_ATOMIC(rte_mcslock_t *) lock;
> +	RTE_TAILQ_HEAD(, sw_vector_adapter_data) adapter_list;
> +};

Why the indirect pointer to the lock? rather than embedding it in
the structure?
