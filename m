Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4715C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 16:35:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EDF540666;
	Fri, 14 Feb 2025 17:35:57 +0100 (CET)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 8285C40647
 for <dev@dpdk.org>; Fri, 14 Feb 2025 17:35:56 +0100 (CET)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2fbf5c2f72dso3715135a91.1
 for <dev@dpdk.org>; Fri, 14 Feb 2025 08:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739550955;
 x=1740155755; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tiTQpB/TXisPwjAj6kjhJQM+ENOGPHj0UoEszSAm1J8=;
 b=vwWhwhlLYfIHI+1zQhjINOdXy5jIXF89Y5NIutdY+PPzK6Cs1ZkOG7OeR7E5Y0MHSo
 +2N/yU5koO9lKmKRJrdrkb8X6FHOrIlX4etB2Vf9hTRqfGRyLt1UTep5FEhA+gfHe+N8
 dKvhzo6AifGmkVYBdCa1PZytAYzXbTDVSf9M9dGZSKoCpEnJAsWU/nzvWdm29g7tNUhD
 cO3woCiY+AMbuhYpaKNeksYQz647A7hvgiqMFw2tbTWewQI/06D0SB6QtHfN4EEeuq86
 L74ZpaBjvRIS+Ug0UR9IRlbwgB5euFXmRRbY0dRhI65mMjb+iQGU3O1fLFppKLnY8mWd
 bL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739550955; x=1740155755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tiTQpB/TXisPwjAj6kjhJQM+ENOGPHj0UoEszSAm1J8=;
 b=EFLXpFIALGdWqaVsnJsvHCgBb1hspq5T4Sg4r0gDABpnTZRYyjOPXT0zFy7bl3CYva
 ScCX3ut1hnDfy4hOgAEhD/LlfxUZEpNJuIVln6VEUW0Vq1RIs0LFrrgLKRRkmuJuFSpI
 /X6OJv/H0yKl2NZjt211biqvJ91JkCiQymCNEaSVDp+h5OLdNH0izmT731R46r4Dpg/s
 9LLQPDsXTdxGxk6KEuL+k5i5r0wFchxv70cYD4WogTb+lNnJoheaV5rZ/0QCusbeiA5Y
 rMcm3yqsw5WJcfe5ZJu4ndCQt8osufmBvVsHOhE7pCQ4WeC2yIiSjzKKKXAbBwYUwNd4
 qmWA==
X-Gm-Message-State: AOJu0Yyb4QX+mgAcyELJpz8qTEpRPDWwk0cBVFsmOZjRZPFLg1UNkBZP
 AOd8jnlX+whShMV9+8S6hZPGvwrw460bOFJq3na+lTi25rnXjr6ncFjNoAocGkY=
X-Gm-Gg: ASbGncspHipP34WzY6k6EyE9oaVeL9s/HL0Uuo96ZdTXlXbEfyU2LgjzwU7NeYKAkl5
 Un93EOCxOUKYilONz3waPetaL133z4tCBVodxaHmm21P5maPyGyXrSf58Jfl1RvrVBwI5VqXex1
 0fQZGGwkBtn1k/a+10lA0jwGoEGVXaqwAJicsoNtmADnkAbUtoYIqGGjgqgVYnj0IepOktQKyq4
 XqfF+ACN8QDG5FOPoziKp7DEg3HyI6uKXDQfAkb66v6iA97GNeMnvSbSmFRhrKZcbc7H6U3eXeP
 6R8y9BO22S73/1G89bNJbQ+aogMKDvKD9Td95AG1ekHMbCXNNdjyNgfN78mQnzxi14aD
X-Google-Smtp-Source: AGHT+IFQBltZ+o3hYAtr9RuBI1qACGJxc9t7L48VeJ5/aF9RMAHVviL2SJ4F0FaQxz+OpaqIS/YPzA==
X-Received: by 2002:a17:90b:4d0f:b0:2ee:ad18:b30d with SMTP id
 98e67ed59e1d1-2fbf5bb2fe4mr16456059a91.6.1739550955633; 
 Fri, 14 Feb 2025 08:35:55 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fbf98d0765sm5381031a91.20.2025.02.14.08.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:35:55 -0800 (PST)
Date: Fri, 14 Feb 2025 08:35:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jie Hai <haijie1@huawei.com>
Cc: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <huangdengdui@huawei.com>
Subject: Re: [PATCH v3 1/2] net: add ptype parse for tunnel packets
Message-ID: <20250214083553.492ddbd7@hermes.local>
In-Reply-To: <20250214015638.29983-2-haijie1@huawei.com>
References: <20250108024632.12152-1-haijie1@huawei.com>
 <20250214015638.29983-1-haijie1@huawei.com>
 <20250214015638.29983-2-haijie1@huawei.com>
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

On Fri, 14 Feb 2025 09:56:37 +0800
Jie Hai <haijie1@huawei.com> wrote:

> Add packet types parse for vxlan/vxlan-gpe/gtp/geneve packets.
> 
> Signed-off-by: Jie Hai <haijie1@huawei.com>
> ---

Not sure about this.
The original purpose of ptype was to support hardware offload information.

Does any driver do this ptype detection in tunnels?

Would the software detection produce the same result as HW offload?
