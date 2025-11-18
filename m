Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EFDCEE345
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 17:36:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 01B804028D;
	Tue, 18 Nov 2025 18:36:53 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id D1A364027D
 for <dev@dpdk.org>; Tue, 18 Nov 2025 18:36:51 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so37565525e9.1
 for <dev@dpdk.org>; Tue, 18 Nov 2025 09:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763487411;
 x=1764092211; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbZdAPlyIe0HWSzSMCeml+YkcrO4QayCdWjQah8ZQW0=;
 b=eR/aeJ7rLQeidbFuLHZ8jxarZ2WzHZu1iSU1Z6GxW7jEWJ4glx5abVeDnE8MfdQNZA
 dwsWFNqZ9wDRnD1+81y2kqLeD10V3bnwIWSQFNv9TVMZCvUIYTN8ZMRXkidJV83BBSrv
 S1gQHeBnItSo5qFa3p/jRaOqyy/RNeIX6sLnMuOJ2A+FakGvgdpGZgesEjGIPw33VJKB
 NYXOwAXB9cA/oZbtQQxX+Bm4PScn8LxhRDIADsgXV3ljhMxqyFlo5f+8oORZfZZfAaS6
 AHiuuWzRouaPUIvN+0AOxiZFMBhsYXGB1vux7ko+m2Q6KqXfUOvoloaPrzYk6SG5ZkUG
 CDPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763487411; x=1764092211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dbZdAPlyIe0HWSzSMCeml+YkcrO4QayCdWjQah8ZQW0=;
 b=ETThkH45QtnY2g3hIQjfkRs4VAiAlYJO3170umccoTiIHh9QJ1ghZ/FUKSNbHGTRNi
 5vFHNKZ/IaV4A7UP1OUYUhZZ+fKsgTTlB/lvYHsRt0XqQC/M0f1x5YKy033TLBu+g4vz
 0HgEnu48vVHJsTQEFXHe6yoPwZm8XhtqI6r2fHv6JxCSiE7lQW/228h9i10M2DzOiKa8
 zYPdp9lfbDhy/w/mP4PM9Jy8+C5sa7BOOjw5RLEXUebbqWULyjKU0HmTAyfVI0FPhjjX
 wle0S8aYkGZ0IpMI38Lu9u4d0YwvZ0oZQWbGS/3YfskXEkL7q+GfK9e6pY7/PlDjywwb
 aVVQ==
X-Gm-Message-State: AOJu0YypGPAYZbpXcQlewU+1ZhpGN57NP2/O4XPrll+92LhrVSH2p2cS
 XNYwV1qeVFBm9kXEuGam/72uUvDfbGWwJZrSDvZJvUvCCygKBu1GThqkVm5ntiFuMj0=
X-Gm-Gg: ASbGncvVMs3bLuWswI0MZVv4vP1ZcVUdkpPL7F8RT2Q4A2hFvKDtEWmKEbeWjNWHnfK
 0ifkl1U3Mv2I0kf4gUfDoDK3bqsQQ3ZAHiojVDBhqaoI4nGsbHajJBoNK6sXt4fWHco7IhbYcE5
 0BfXtN0SeCG4u/ylM3dpVPbUazU5x8Ge4LYbIFG48NmZ9Uk654bi7/HNOHg5DzuriguD0Ztxbv4
 ytmKYYTWREoQtAiaQeDm1GPQwBtQPro/3ytZV4x3Ai/qHRouGmYWXtHGpEuXWpipybYqckXAOEP
 jcu8CRBj19uts7oy5qSCiNuSHxz8KvLc7Q8A4v2+wHODWXLrPSraBdqQIYP5G4aA0Cgvw/qzK7D
 26bRKqW7MZkhp1da0aZoWfYCSQEJS7zP8RiDD/fVCgZVFBikuSRawKLty3EgHaZzIR9edSlpFpk
 9+39BoFGvHra+gWUDdwqLCAytBoYtgO6ksdEDqnGVkBvHXa0zxVzY6
X-Google-Smtp-Source: AGHT+IHCbP1+CN8fbtQCZJ8AdkkCHYlRm5DCVhKfMNxNRiH5Bc/1BvZ/0IiOEE1G/nTGW8irMln27Q==
X-Received: by 2002:a05:600c:1f10:b0:477:8b77:155e with SMTP id
 5b1f17b1804b1-4778fe4a046mr155679375e9.15.1763487411148; 
 Tue, 18 Nov 2025 09:36:51 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b1041defsm1419555e9.15.2025.11.18.09.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 09:36:50 -0800 (PST)
Date: Tue, 18 Nov 2025 09:36:45 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3 03/20] uapi: update to v6.17 and add iommufd.h
Message-ID: <20251118093645.1d13d95b@phoenix.local>
In-Reply-To: <a956a800cba7dcfd85387db04447db282bfba625.1763483253.git.anatoly.burakov@intel.com>
References: <cover.1763483253.git.anatoly.burakov@intel.com>
 <a956a800cba7dcfd85387db04447db282bfba625.1763483253.git.anatoly.burakov@intel.com>
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

On Tue, 18 Nov 2025 16:29:04 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> In order to support VF tokens for cdev-based VFIO mode, kernel v6.17 is
> required. Update internal headers to version v6.17 and include iommufd.h.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

Acked-by: Stephen Hemminger <stephen@networkplumber.org>
