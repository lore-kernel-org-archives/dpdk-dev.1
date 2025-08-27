Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E43CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 16:30:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAE824029E;
	Wed, 27 Aug 2025 18:30:37 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 4FADB40292
 for <dev@dpdk.org>; Wed, 27 Aug 2025 18:30:36 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3cbb0df3981so1021706f8f.3
 for <dev@dpdk.org>; Wed, 27 Aug 2025 09:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1756312236;
 x=1756917036; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tpsPTnTwcHgizEhV7AfQ95iTgkhjFrVuS1STItkP0uU=;
 b=IU9dEDCFUhVL4lL+DRRJl5fpNR2kzm3nybMdbs0SA7Jhaiwfk6cpBUyaKuS0n3KxQr
 dpVNutyZglqhpTEEFlFqJnN9O7XrGlGuXcF/MGDIPiqa7jadFmN8tGsJoGsMtRstnkuC
 2LTCQIrZpK08fGZADlmb/JKBbxcprwvhhQgwUHRVxEvBNuPl29nYCSEMVeUp9/728j0F
 /u5fZGkeavjb0RK0nLC7i2wJCUqmVuFjGna9ywbMwSX/v6V0ieAzYQwmcQNMlpDDvTvA
 p031lH4MWxVLLrD9LHgC5MzMpwzlbs73RryiBSVqFdZyNJgZqmESjkqq+asdtUIQgteM
 o4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756312236; x=1756917036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tpsPTnTwcHgizEhV7AfQ95iTgkhjFrVuS1STItkP0uU=;
 b=VuNMHW/hrQYIuvHyT8Vnh3GgvbZndp+/yHyXhaVJonSzC+Bybaz186HQ+1/T+omXic
 T1g+p3tPzvmcpAS+YAWFmviadUZS6TQxXPaboYsExtMktrt6q8yM/Myb4haUGWwsyyIs
 JoEbao1wuxCXxukWZyRRLWjATq0h50035Zpt53hqwIGb+7sWM5MUkwGCm3U07BUq80He
 tsQlnm6+CWl2U4KS4jpLpiKLKnnjXfWTf8fESnQtq1H27KwkXOdmgz+D0PjOD9xcz4Ne
 /4MZpQIrFk2BPGIu+wZJJffmIA/KGYuJZ4ZP6l+FNGRn6EE2nA/KweONhFVGEEAYDzQ1
 Wqwg==
X-Gm-Message-State: AOJu0Yztc1yqxf8ZVpBspt35ko8CM6UwhWk3GBad7ZEpOhOz/HLH9VgT
 4a2I2+bJiCcipdD0XijCikNmYZ9LJ23L97Ch/q6ooDryqYmnPiuWdV+XEwTWOPyHZdE=
X-Gm-Gg: ASbGncvFDUwTaYUvjuR2bCNF+09OSD90S5Yn4pV9ahXDlQtYkk1NNRWosF8LFwtj6od
 Nr0L7v7EDETIRjCaggKM+DPwa0695Xw6JM+YiXkds8EhwJe0Rw4JzppPJA/8gLUhC8G+5Q8D21C
 PTpK9wg5wPyjrbqAFx0vE0yndg5Yh7dbTdarT6m28QVf+HxbDjenvmoE2mnrR8Rq17axHW0ieaB
 GAhhbLV36caJm9dqgI6aupr42PQGU5RKGsklh+4V63k4opWFGZ7m3YWhYt2TiLho/0hiJ31VPOX
 YtkLqBGdm1io3PFzlC5UWHwMfEydiHFkNOlKDwuD3ZOMAetYpna915vdiA7HPvhccJALRkrVgnc
 KN5+luosWcYM8B9+RFhhtMF20lVMOTCvLr3UJQ0rvwxSYbImUSvT/+XOxOm1cA55eXvM/BWU5/n
 U=
X-Google-Smtp-Source: AGHT+IEu0yu6rRD6ppVScWdm/JthTwXbBSDDqXKJuIsr9mMoAjffPo3FigwAR2QjoAWTdP2OmZKaaA==
X-Received: by 2002:a05:6000:1a8f:b0:3c9:a722:e186 with SMTP id
 ffacd0b85a97d-3c9a722e3a6mr6782793f8f.30.1756312235881; 
 Wed, 27 Aug 2025 09:30:35 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6dc1sm37319195e9.1.2025.08.27.09.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 09:30:35 -0700 (PDT)
Date: Wed, 27 Aug 2025 09:30:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>
Subject: Re: [PATCH v6 02/17] net/nbl: add simple proybe/remove and log module
Message-ID: <20250827093031.7715c1cb@hermes.local>
In-Reply-To: <20250822090359.614551-3-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250822090359.614551-1-dimon.zhao@nebula-matrix.com>
 <20250822090359.614551-3-dimon.zhao@nebula-matrix.com>
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

On Fri, 22 Aug 2025 02:03:44 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +
> +RTE_PMD_REGISTER_PCI(net_nbl, nbl_pmd);
> +RTE_PMD_REGISTER_PCI_TABLE(net_nbl, pci_id_nbl_map);
> +RTE_PMD_REGISTER_KMOD_DEP(MLX5_ETH_DRIVER_NAME, "* nbl_core");

What is MLX5_ETH_DRIVER_NAME doing here?

Also title should be "probe/remove" not "proybe/remove"
