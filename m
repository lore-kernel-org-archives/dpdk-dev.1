Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C7C87FCB
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 Aug 2025 08:51:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE05040270;
	Wed,  6 Aug 2025 10:51:55 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 0E5D540264
 for <dev@dpdk.org>; Wed,  6 Aug 2025 10:51:55 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-76aea119891so703223b3a.1
 for <dev@dpdk.org>; Wed, 06 Aug 2025 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754470314;
 x=1755075114; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFgDc/Sb9oQX5mWHuycsoKVRFhz/s0SrhMGeRj56XAA=;
 b=LKioqPVIaDh5ZSa+HhJiGHDLytcQRsmCE8aZYpsGF1FPQv/ZNS7pXrheigEGiuZmkP
 /tlJo6LfMTqcDgisPZSnTNkXH0zqlc2bzTKqq/ExpJPrnbjg/cn3WKK8abYg6BfLMj3/
 jULyl8b8lZ0+v+lNYGNFsBd6e2ROzf5mK/66Mjte5kOf0dI/YeTUBnMHFGpPjcDKsYGc
 M0snP0puxxM7kFgxR0RiOBqgyIrt+BiwMC0r3yx8XRMc0ehNfEYZvhvD2mgQ7XnGHrMf
 7sbMNxsTNEXIudVQ1wYh0KPS0FXdSzr6TNdJwz/RP1vcRnCr1ZCr4g6qvO0Z90mT4lBJ
 GkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754470314; x=1755075114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFgDc/Sb9oQX5mWHuycsoKVRFhz/s0SrhMGeRj56XAA=;
 b=TtxfFgwm1utw0zQaQ/STQzqYbXX6xnRgu213wd1WARCTh94xQXWeUi1IdqrYeiRQMr
 N1/hkn1O/2+wGCRj4NNDBFuJvps+LycCucqRFbV8ldLhIgyIasx1piyW8o1+z5aQ+3Pr
 He5bIxJpgmMCKIjtjnUel5TOd93CaKj+lO6+smWQp5SJaC/WzYYG7PgLhANkrqiPeH+O
 AbMIKHXsaIOwE2k8bqeL9rF5/36ZzT7ZQjjVEHrbsprVQiq5YEUi+paMYKvi1trIfPGl
 FNBTEXsmFc+oWDoYwInPhWyXsO1QcKY7bsvYIi9pMiUsWynuYQd9EO9gP4BMN0RGg8Xa
 wfjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyHiEpPzeRY6vibIhsK8KTi5hGd94B0/kB3X1aMu4MFtzZsAxLBONF8glSKXdhWQrtnlo=@dpdk.org
X-Gm-Message-State: AOJu0Yw/Ov7cHKgOfxkeNIqe4317VQW+TSuQTshsbyxEL2gKWyHoBnX+
 Bhzcgrk60skKf3ry9KO8UsGE1uktD+7Ck/FlCBqXXmjIhcTwTe1HjdmsZRkv1aSF0Jo=
X-Gm-Gg: ASbGnctht2OzpmGhwIW60z+6eM3Va9i5P73gbHPCzobTNQ57QPUzxA7fUVGOA1m7igu
 1oxd3N5FW8v23AjE1I640mfkkQebK6uRjDSjHaTOJvMvrdPlXUUG91N/SpbOvGs4U3Ss/njhbMJ
 r0jE0gq86yk70kM//D/fGhXwV96e08+ZyRJoh3lvdBVVYRaItr9EcEUSiCtd9imDn5qzwz+Khss
 x4+7VTClGcf4KY5KSmBQxHJD79YKKJZJpf/yjoehydP8c6+fYImcPEVhsoeBC+9LC7n6WDBWV9i
 U8yv/uwezbOK6PpvRpZh3vQKxsc21KCHWASvFPc/n0fDEav1LzZqz+WQ387LvmlV6A765EpoZpP
 /D/4P4usGzU2X8ZNwpmnRaFAbp7M6f144/TYOJr7qLGXX3aihfJ359j6cDE0Wpo9rgdDDaA==
X-Google-Smtp-Source: AGHT+IHSk8fnFt0aI7oc0erZs/kC/CaS1ds+gvC0S1e8u8x2JtwgVckChtoDhSGP6uNmcEm1Xnl2wQ==
X-Received: by 2002:a05:6a21:339b:b0:23f:f729:2e72 with SMTP id
 adf61e73a8af0-24031900043mr3050722637.1.1754470313950; 
 Wed, 06 Aug 2025 01:51:53 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422bac0d6csm12697601a12.38.2025.08.06.01.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 01:51:53 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: ivan.malov@arknetworks.am
Cc: dsosnowski@nvidia.com, viacheslavo@nvidia.com, bingz@nvidia.com,
 orika@nvidia.com, suanmingm@nvidia.com, matan@nvidia.com, dev@dpdk.org,
 stable@dpdk.org
Subject: Re: [PATCH] net/mlx5: fix connection tracking state item validation
Date: Wed,  6 Aug 2025 04:51:42 -0400
Message-ID: <20250806085142.739366-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4a26fe30-fb35-f306-d0df-e935ba3a0a89@arknetworks.am>
References: <4a26fe30-fb35-f306-d0df-e935ba3a0a89@arknetworks.am>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Ivan, 

The multi-line block was not closed in brackets due to coding style.

Spec provides values to match (e.g. a given IPv4 address) in rte_flow rules. 
Incase of the flowing rte_flow rule, spec provides in 
mlx5_flow_dv_validate_item_aso_ct the conntrack state to be validated. 

The following is a valid rule and it should be offloaded. 

flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 1 / end actions queue index 5 / end

and the following is an invalid rule which should be rejected, as there is no conntract state corresponds to 10.
flow create 0 group 5 ingress pattern eth / ipv4 / tcp / conntrack is 10 / end actions queue index 5 / end

Please check https://doc.dpdk.org/guides-24.07/prog_guide/rte_flow.html#pattern-item
