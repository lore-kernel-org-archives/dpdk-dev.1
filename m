Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6455CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 20:32:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AA1940658;
	Wed, 24 Sep 2025 22:32:08 +0200 (CEST)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by mails.dpdk.org (Postfix) with ESMTP id 03F0E4064A
 for <dev@dpdk.org>; Wed, 24 Sep 2025 22:32:06 +0200 (CEST)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-4da72b541f8so3260191cf.1
 for <dev@dpdk.org>; Wed, 24 Sep 2025 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1758745925;
 x=1759350725; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxyEjVyMsXhtWAe7FmiYI+HLh3KFk1NeEDcyF7KAAZQ=;
 b=rrCvs7r7jQfiVngImTmgTUhaiiBBrD3DN8OJ/WlyS009s/e935DThHdkHdhh/ZRexL
 B7WfqGz4+4W4a192pAZDqC2h1NjN9poCSG1xAJN6wH6CdzWzzAaOk8xEL4/hhYL6QFxr
 xsGd+eJb7eIVpZr1ApukK1kM1rBoz+WXqQUk/99p00FhZbD0gNhbJAGuDSBqHAZVFe2V
 6zVCM/kmhTaHunxTdAg+g85mkX+ygghMeDNUDrbocgphArFdrhidDnJ362MIKbHVfBY2
 rIAlTJJlZGrTVSHpXNAAXhK0gze0gVIYGFlecZNt5gkDKbtG1wOo9G7OcUT2qMsXzfzO
 nM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758745925; x=1759350725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxyEjVyMsXhtWAe7FmiYI+HLh3KFk1NeEDcyF7KAAZQ=;
 b=B9lXkOVnYaAW3A4WzBM9nKpJsMmVCQ8knmuu0woJzByrh62SVQw4VVNS/WHD/kUdMd
 fM1uOSNEhn0G5gb+KxKGVXiqUfi8+pM6xyS3Fw1uq9T12XTGjVC2uBxD8y7YH4zSeMIi
 BQpwa/eHP7MzRoJyK1Nq+BzRikaV45hEyh4tth7FEvMH/i24i5mrEZo2FLTwY3mPtOtO
 jgyMF/rAhsJKzdbZdN/w3b+PBCHjLymvFs3o+63DhQc8yTb7tfZvqaDyGNHDV7rMFem7
 E5vG8a7abl+sQyMJoP1KcTuT+EIjEckrvugTJkERJzlBYG0k7smq4+R6eiGUXARgFeAy
 odgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzqn2CbGl9vMKt3Y98ZzImTgdstv53Hl5D9tBlxo4A4Cu0n4QkXJQzaKGgrM8P1RW4weo=@dpdk.org
X-Gm-Message-State: AOJu0YyB+wfBi5+oxLSUyLorw4zPqxMrNst8seJkpmRvPd0Zr8ilpRQm
 GtFC+Y4PJxpXd0lM8Qmx+CP8Tsg4GCGVEMdjCE2jbQOhjA0tB7SAxdNiJ0DelcwCr7+1Acfps4P
 ySHUn
X-Gm-Gg: ASbGncs7AvJZnEmtFgCsw53oUzuqRkMohLVSWx4jnl2aYdI3Q05QVOf4hxptnp94YmN
 bO2z/DJGc7zS2dxh5HR/MHYiBct/PPgR25xezBJxfG3e2uUh53ZZNofnRMtHu6WfHDthM8+X58E
 /KVezzl48KZPPYRgZve96mqR4yFCTpsmKpz8vHGrOVVRw1OniyyNeVxb0jyzsdEwPaFGH8XQZfJ
 3DC1bWtetFRufgSb33J8Fce56FddxiINnhDdmULtob9ZPGrAJS2G5UHP2cdg/huDkFZQkjJvLQc
 Jib3XmLGgmfMNsFuy/CWtiqTyHQ2Zhfck9F2zKIbtA112CBiLM1o4VFJnjHDH4ct7awvAy0cuxr
 vqFa1FgmGb4wf9nyitk83lToQvd+EYEV/IC/uak8EkkhPk5TP0bY917aiopw64dk9wBPDtoF5Xb
 E=
X-Google-Smtp-Source: AGHT+IG0ATQpQiLohBrZaM/a2EzmEteC+xL74xoP0V55TxwY9IZaAzNXWFdGpHNi1VmESbZrSRtocw==
X-Received: by 2002:ac8:7e86:0:b0:4d9:c572:f9b6 with SMTP id
 d75a77b69052e-4da4bbe418cmr15058901cf.55.1758745925063; 
 Wed, 24 Sep 2025 13:32:05 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8013e5d5f8esm672046d6.27.2025.09.24.13.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 13:32:04 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:31:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Tianhao Zhang <zhang.tianhao2@zte.com.cn>
Cc: wang.junlong1@zte.com.cn, yang.yonggang@zte.com.cn, dev@dpdk.org
Subject: Re: [PATCH v1] net/zxdh: support multiple PF process flow table
Message-ID: <20250924133107.23414572@hermes.local>
In-Reply-To: <20250924082331.39962-1-zhang.tianhao2@zte.com.cn>
References: <20250924082331.39962-1-zhang.tianhao2@zte.com.cn>
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

On Wed, 24 Sep 2025 16:23:31 +0800
Tianhao Zhang <zhang.tianhao2@zte.com.cn> wrote:

> +static void
> +zxdh_priv_res_free(struct zxdh_hw *priv)
> +{
> +	rte_free(priv->vfinfo);
> +	priv->vfinfo = NULL;
> +	if (priv->channel_context != NULL) {
> +		rte_free(priv->channel_context);
> +		priv->channel_context = NULL;
> +	}
> +}
> +

You don't need the check for channel_context.
It is better to make both pieces consistent:

Like:

static void
zxdh_priv_res_free(struct zxdh_hw *priv)
{
	rte_free(priv->vfinfo);
	priv->vfinfo = NULL;

	rte_free(priv->channel_context);
	priv->channel_context = NULL;
}
