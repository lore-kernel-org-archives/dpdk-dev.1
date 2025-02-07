Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E2EC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 17:12:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E1B942EB1;
	Fri,  7 Feb 2025 18:12:48 +0100 (CET)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3F78742E9C
 for <dev@dpdk.org>; Fri,  7 Feb 2025 18:12:46 +0100 (CET)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-21670dce0a7so56055315ad.1
 for <dev@dpdk.org>; Fri, 07 Feb 2025 09:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1738948365;
 x=1739553165; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m/PJoFDKDItsVRvbxgdcMhRyLHXBHYCoGQJSl/N2HE4=;
 b=YiEF5o/CAfX8evnFi1oQAr5TS3CWIePU7XppjCcGsBiFVD+9J7RQ3cXnEzYc/2Y3eF
 KlW+fk8K7ygRKAbeanHDBBR3Gg2p6stGTpEt39rU5nl/XB4pZbX8FXm0+SIBdW/316Eu
 nFmP4G/2mTKF5mcYYhKp9jLd1IlFgS686FuH8X1wuSCKKZ5N97jarTA1I9FxrxxBnGf7
 W4ulM58lTfqsE8fFSSlakes+ORdSHqyGwimS0aaQUVmXfnhzWkMF/6xbitd0XQYZxHDt
 vmQ+idP1zI8bnSHdhk1y2fn+aWXJ/RG0S5gutd6WnWy1z+TyovdWxAx2soCH/408YclK
 S09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948365; x=1739553165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m/PJoFDKDItsVRvbxgdcMhRyLHXBHYCoGQJSl/N2HE4=;
 b=v/p+eNCDt1dHM3HX+AoQq2cyfKcU8erLuqSeaBIO99wfR5/eYu9pYAY5O6SfHB3jmv
 k09bi37qm89C01LrRuWcpC1awReoNdF5LVxRWXSRCjcxSxKfdS/5Nw0ghhTZOqZdQqRg
 elVcDa9gLb8u2JHF6gWesEYdLcXZ4EdA0fkmnyprxldZLszClSwmUMZGcHtwwc5ZbmVY
 FEnyCVHFj5Mk8cOM8uynd09TflGcC58d+IY2yGHvmfOadFVQpVF4VbfWPYdyUnClWfCU
 Na2KWjh3jognwh4GSOH7TV9M0AvRHtEfy6oxlzVVSVyBGYG+09LqdST0mKB4QYE/TYZW
 tpgg==
X-Gm-Message-State: AOJu0YwQn2APf3eyFxlON843sT31wnmHIOG7Rdov+CZqVaOjaRUxU8U4
 GLZric36t28qMfvkhNjgesPT4ah3TOoRKPzLMnYuDzCzhidr+bAE3DJCEXeae20=
X-Gm-Gg: ASbGncvKgvO+lyQDmJTqVflNDjZzklHCffao7cwCeL+LWwsUHyICEx+ho9kD+tgTmvI
 /s8jd+UlwKAYmIfziu17dy2qkQKmWaJRQ94pEVxUKDsGXyNW/Hh+1U+766KbKWYsREoJ8txtDVX
 kerzHMqLQbwz/jzyMQgVikKJbD+MSP+w4p0MxmvpjHt8S/qmeKc3J2UjI3Dteycw8zzbbNFo5Ea
 t6SoSHG14uyuRceKpIDm5jXAHmoBYGgMpn7H4z6Cr1+IyZ8Y4frxStWyz/ssb3oLm4RsKWalupc
 WJLP+MR1fL4Sw0GyYG14RhP6ek2mvMlHOn475vlQmB5HZROlbRsHqA6+XRB1bvmZLyfH
X-Google-Smtp-Source: AGHT+IEALeCDc7yhrehnV4l4VSkeGcETclLj45XEQFmuz5O3MSwxW6vT3WWUGcP2dhheAQtLANt+bg==
X-Received: by 2002:a05:6a00:6c90:b0:725:eacf:cfdb with SMTP id
 d2e1a72fcca58-7305d55deeemr7503558b3a.24.1738948365253; 
 Fri, 07 Feb 2025 09:12:45 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048adb10csm3352060b3a.66.2025.02.07.09.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:12:45 -0800 (PST)
Date: Fri, 7 Feb 2025 09:12:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com>
Cc: dev@dpdk.org, ferruh.yigit@amd.com, kai.ji@intel.com,
 brian.dooley@intel.com
Subject: Re: [PATCH v4] net: add thread-safe crc api
Message-ID: <20250207091242.07656c4c@hermes.local>
In-Reply-To: <20250207063758.3971992-1-arkadiuszx.kusztal@intel.com>
References: <20250206203844.3874038-1-arkadiuszx.kusztal@intel.com>
 <20250207063758.3971992-1-arkadiuszx.kusztal@intel.com>
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

On Fri,  7 Feb 2025 06:37:58 +0000
Arkadiusz Kusztal <arkadiuszx.kusztal@intel.com> wrote:

> +* net: A thread/process-safe API was introduced. Old and new APIs share the same
> +  function names, but the old one is versioned. Replaced functions are:
> +  ``rte_net_crc_calc`` and ``rte_net_crc_set_alg``. The new one is ``rte_net_crc_free``

The first sentence should be more specific, and avoid passive voice.
Follow the style of other release notes in other releases.
Also, should indicate that versioning is short term (until 25.11).

Something like:

* **Changed the API for CRC calculation to be thread safe.**

  An opaque context argument was introduced to the net CRC API containing
  the algorithim type and length. This argument is added to
  to ``rte_net_crc_calc``, ``rte_net_crc_set_alg`` and freed with ``rte_net_crc_free``.
  These functions are versioned to retain binary compatiabilty until the next LTS release.
