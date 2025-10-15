Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA9CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:11:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A0D6410EA;
	Thu, 16 Oct 2025 00:10:55 +0200 (CEST)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48]) by mails.dpdk.org (Postfix) with ESMTP id 6196E40DF6
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:10:53 +0200 (CEST)
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-87c103928ffso1736446d6.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566253;
 x=1761171053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTpfDdXu1OcNuw4Mmf2+tlHdrU8naAIA60GxqbaZQMQ=;
 b=oz2/rXzAtih1hym7jf7aJcYl5ZFjuU3FfYsrt2kDSyT6GN+kjOGbXTSE+c+JF4daa/
 9BvLu4MMl7WVgXwkIQLR9h3/k2Rb2L8mMkAiXeCZ41YULIbE80+uIEVXSo4+AfMe8AMd
 BreD/ZWfr8YO+snaf4qxjTHGsdkdNQ70WgyQoDfx7OhSW7JagyyNZ9exJWpJGxm9010+
 GxqENmtCknTjrIWJBMf2PQt7/elDXeg7B/wcCzCXvVkQTT16t0uw7Tezwczp0DpPKbdO
 hmTIK2Qz/91zpSC1q13U1OadFWPXILbBn2tFZcUrR9YPgBkP8oMKaww4Szt5YYFAfP8a
 3Oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566253; x=1761171053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTpfDdXu1OcNuw4Mmf2+tlHdrU8naAIA60GxqbaZQMQ=;
 b=QMcA/6XW/Hh+ZPjTKasnH6oZxHOk5tWIvuf7TGV5s+aMYkbFpJaUIiCcjrJ5W8EexD
 OC6/6L1jnwUq2tcSjF6sUr+eBrM4QJjDMN3jmsxdgnm1yMd97a0aoQkDHR72wGtPy6j/
 qp9QvAl1QQD6pd2c4EL25SvbHOaZyYnXgOszjdVI1fY14UV3JPXrKI7EOD7wf/0CH201
 f1WfVFpV7cl7g2inFHJah2t3GottSt3Tfax3qMddrqzjuxt3L1hyR5X3Of41k0w8msXe
 eKAtEycrtmqHUb4+3jvw1eq6awMw7GftlnQth7JZ7AG2qBp9WE02sj9mC1FQ+Zl/c89j
 yL2Q==
X-Gm-Message-State: AOJu0Yx362j21iPqiRa3zjzJfW9wLAvOfdA4pP75wNozHK5QRzxS9Yf0
 nWo+1Z4MNLhjVdEtq9DEXqacxltTNJ8jWZzcDl8RqD67AyKyvOCMzMVjUEcmggf+VAM=
X-Gm-Gg: ASbGnct23L3VlNOPgHv86+Dxi11gfR9YCEOaVxf5VI3L6QKq7VSvLIDldz9t5IN9V/U
 9o0i/joFuGiqvPTpk4qETq9ynm2sUGdHaa4SvQInwAetbs3gC4kjLYYDpQ2eF7TQ8Hc26H35UfU
 itEwF1nkn6Rda3KLo1YpgR4wo7pNSaMHaCP8r94LKpnN6A9q23+4bzCnHg0MV76TPUfY/qs4+Xm
 kzkIx/fVrF+Vdqfnif7vubx9br5+DrJ7LXEGyRDO6phFRY/jn585YLIMVhTGYn49jjV5zIWrKme
 LEKOUVMNNkvnkZg1vgEdKK+hWPKxrMnUGDqpP637Ss+JejkAHqjB2MkfqHei87FWG/0lpEVDL3z
 EMsuxQWh9ZSeiSrixZSc8yWwRTvEEkbDovN8/8/1vZZIFOjJsR/95e+Hg9qyySWaCpZWxnMGnae
 E+2pAHeJJhJvmfXyDo35bXCXA43Llf8zDZfvdp44oyBIVDQlgD2YfH
X-Google-Smtp-Source: AGHT+IFVa/1+c23Q/rTK2VDmUdHZF5NpKPufbbw65Cx6RTKPNIb7CSHEY8xenDzW3wMiCOXI3OxpMA==
X-Received: by 2002:ac8:5d4f:0:b0:4e8:8722:4ec6 with SMTP id
 d75a77b69052e-4e8872250b5mr43791471cf.61.1760566252735; 
 Wed, 15 Oct 2025 15:10:52 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c577e6sm27732021cf.7.2025.10.15.15.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:10:52 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:34:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>, Bruce Richardson
 <bruce.richardson@intel.com>, Gagandeep Singh <g.singh@nxp.com>, Sachin
 Saxena <sachin.saxena@nxp.com>, Anatoly Burakov
 <anatoly.burakov@intel.com>, Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: Re: [v1 01/12] net/enetc: Add initial ENETC4 PMD driver support
Message-ID: <20251015143421.2da77870@hermes.local>
In-Reply-To: <20251009111633.3585957-2-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251009111633.3585957-2-vanshika.shukla@nxp.com>
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

On Thu,  9 Oct 2025 16:46:22 +0530
vanshika.shukla@nxp.com wrote:

> From: Apeksha Gupta <apeksha.gupta@nxp.com>
> 
> This patch introduces a new ENETC4 PMD driver for NXP's i.MX95
> SoC, enabling basic network operations. Key features include:
> 
> - Probe and teardown functions
> - Hardware initialization for both Virtual Functions (VFs)
>   and Physical Function (PF)
> 
> Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
> ---
>  MAINTAINERS                            |   3 +
>  config/arm/arm64_imx_linux_gcc         |  17 ++
>  config/arm/meson.build                 |  14 ++
>  doc/guides/nics/enetc4.rst             |  92 ++++++++
>  doc/guides/nics/features/enetc4.ini    |   9 +
>  doc/guides/nics/index.rst              |   1 +
>  doc/guides/rel_notes/release_24_11.rst |   4 +

Release notes are in wrong place. This is for 25.11 release.
