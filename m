Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA644E8FDBE
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Dec 2025 22:39:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C98940267;
	Fri, 26 Dec 2025 23:39:58 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id 57B4E40262
 for <dev@dpdk.org>; Fri, 26 Dec 2025 23:39:57 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64b83949fdaso9742405a12.2
 for <dev@dpdk.org>; Fri, 26 Dec 2025 14:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766788797;
 x=1767393597; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rIQ2aLyM1fCb/zEmBgtgR8O7aP+ybZDBW7wuKCF6Z0Q=;
 b=hYENfYXVYJkw5Rkrc02V9Egj3j15AfZ+gpxUpBScDGNCScMIN/A008j1zufMkcUp4Y
 SYpVkkwIdvbupcVWT0cxj6YwjjSz7R0pOEkgYcOJBP4Bt8Qk+qIm8yED8WbRdAtKN0Va
 TotNNNQ92+SyhbhIQhmwbWVkRW45H9KMmnQoMxwXPnhEPyfKEbPcYqBUKDYj5X72vqmv
 3fJQxdZgZgq3ZO6Gz7wVi20XvvU5+Bg+RkJDjvJqHTHdimF2meCZwNF/4TUcNA9cFR8/
 YEkWp1CF7SCKCszlxXG/263t0JhQBeaMQdXuEWwgH8oon11yJ0C5LG2ebsq63YGoTYz9
 xU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766788797; x=1767393597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rIQ2aLyM1fCb/zEmBgtgR8O7aP+ybZDBW7wuKCF6Z0Q=;
 b=m+65cfcVa+tM2n9bXgo/+48NY9aX/n/LjyDdnavYSbmfXnOBwXIkmXFHcl2VZbcgtc
 hCGFSvuwkVTsOaR9mzWxIwoOagrVleEb8EPmIam8GvbQqczevxUpE9FVgQq/rtIsn7K7
 3NJzfPy+JBb8kGBbgBdQ6+4iw6CcZbdrQkCAIWlVgF44QRvwWVOgmUTNhhg2ros6JCYi
 TMEaBZrGugpXhy+b0u/4jx+g4kGQrywnHg6KfyXIrjR6+SP+25YPAUNStMCCEHCj7xiK
 3e/foK0abdLbTintyT+9LYwAYZkULacdzkek8lwfWIz+rLgvDbUXBE9idgLBR6T7fEOl
 DZOQ==
X-Gm-Message-State: AOJu0YyhxbmlLLeuMwczK/QJ/8YoAkYjzXIzMubH7oVq/Xe8kXs4HX7N
 +ejopUMV3sYPku1VmhzH5JzoshdTgALDpiMtogjPM1Vz3kPciUTOwaEOVoTsiCLAF9HM16cLyFy
 iQp3ibPY=
X-Gm-Gg: AY/fxX4PIhuKWvEOXUUHKtup49pG5OGFIUzcqIebUyRyUd9G3dplr8Vilww+wNz7cmO
 1GkWLDthFiFu7axVLj+hQhNBDB22syYEXkTpfU8uNCdapKzbwxD0j9y1vn5f9H7ImYE56NSW834
 vdMbDcqDkjT5MEVBrMtHahc5pGyCx5S4Gzed3jIfCZgF21WI0pHcmI9V0lykRS4YyWwquoREmzP
 x7JT4nRhZowRagA9RfnUlWRTn4qvxK2bsK7Y7kmeBQojUx+ITGI5DR/rL5nijH0sLI/V+Jn+eB4
 V5xJE9CI693RFHx397OMWIq1F3rdiJl89KmHpCx8AuIgSos92Zya7TxXLTgyR1wfuOxf4zxCiEa
 22kt78GWY1brRV8uuHd3Ki0Bj7BwDUYKDQjC6jwVpT3jnfmQiaO8SHmO8AfEdBQo+vDgBTyuavY
 B7wIjDlCeo7eAF1ByXOEqCMdb7s8GdNLRM7VFfK462a+NvzUlXEGOF
X-Google-Smtp-Source: AGHT+IHQDbzCPvyDwEts5uXHNjsD42V8o+Tn/ZAwa+Usm3e+nzZ51GRY1I94XGWSUJ910PfvhD5DOA==
X-Received: by 2002:a17:907:7e91:b0:b7a:2ba7:198c with SMTP id
 a640c23a62f3a-b80371efe93mr2848823166b.59.1766788796709; 
 Fri, 26 Dec 2025 14:39:56 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8037de142csm2446767266b.38.2025.12.26.14.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Dec 2025 14:39:56 -0800 (PST)
Date: Fri, 26 Dec 2025 14:39:51 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v14 01/13] net/sxe: add base driver directory and doc
Message-ID: <20251226143951.6943503a@phoenix.local>
In-Reply-To: <20251225092224.227202-1-liujie5@linkdatatechnology.com>
References: <20251225081201.177111-13-liujie5@linkdatatechnology.com>
 <20251225092224.227202-1-liujie5@linkdatatechnology.com>
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

On Thu, 25 Dec 2025 17:22:12 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> Adding a minimum maintainable directory structure for the
> network driver and request maintenance of the sxe driver.
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

I do not like that this driver has to invent its own tracing facility.
The DPDK already has one, and adding a driver specific tracing is
a bad precedent. The goal of DPDK is to abstract the interface to the
hardware and make it possible for applications to work everywhere.

I understand that you may need/want more data to resolve internal
driver bugs. Is it possible to use existing trace API for this.


Build is failing please resolve the issues and resubmit.
