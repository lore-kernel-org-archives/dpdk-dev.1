Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900A5C624DB
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 18:45:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A8C34026C;
	Thu,  3 Sep 2026 20:45:52 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 2458040144
 for <dev@dpdk.org>; Thu,  3 Sep 2026 20:45:51 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso111613a91.3
 for <dev@dpdk.org>; Thu, 03 Sep 2026 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788461150;
 x=1789065950; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d1WolBRA9/BHCk68ReG0kxP5xQ+9Bf/EpfHvt6YAHwY=;
 b=cTgxGJjQhm/OlgCKyqj23J7V/sBM1pP/DLH5d9RvxAKDgtLPwKuNhLCiwf/51XuaEv
 vg6JeR299uz8gGmhAP6lfEXH888JOSVs0+k632Id0odSAvsS3WKgSMyRB/Wl3dzAfXVo
 Psd3bMDwM3KC/F1l/bOp9TeP0YXuSBZtyWz7Uyd8PdQaoJRiFTNNx7xOhr8VJo+6qfCq
 WZt1Tx9+CllH81leMgxBbVwMq4jimgyicSKHUjGA9cC/+qTm9DqfH7nmO0BG+XUVmzJ1
 KTzmffl+YlNMJ4wM+r2tLQ4gKLxpmTgPbK+VW5a5dFqe0NWTWayZllubpZD0du81RmRg
 D2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461150; x=1789065950;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d1WolBRA9/BHCk68ReG0kxP5xQ+9Bf/EpfHvt6YAHwY=;
 b=nD9GFSwZfndX0CXkWILLjN0zKUccH40Zj3ydEOxW3IdlK+MXzLpxurGsb4rgy221bE
 fn+DV4iiFPZUFdwCJTYvj9B+Y5lFBwilNF7/izLLP+A2iiYR3qaRbQ3jWp9X7NgcbjL6
 ydFgwlxr57Sr5fpxsJIvRFKirPNwfLKmbmiu1461zxjbUu1JKY2fM6sN49rvY5qRPY7O
 HYERP4wz4nQVE0hO3J6Jex0sna4wYz9IkX3UQvxEv3F/B1lC7kOpSHJP9UE6/Q2jDLVT
 U/c8FTr3UX3Dv1NPBPwo7dSsvoF/1haK3u4NqJ4D00QI9bsYcUdV/XJtJlVBVgoQW0jd
 SF6w==
X-Gm-Message-State: AFuF++mrTNzQ/vNAPcY0TDgDypYsC1Oz33wIZDqm38wqvlzieglU7OeE
 iH5NxLvHAAMSw9UiHQH4B9gOdvm6oI1xriJPTwkiYWNHEw0ZZCvuPvk3OA3clW855Mgav3AMqxG
 h3tLs
X-Gm-Gg: AYBFou05RsSzpPg4Qm+yTzHFfDEeXPgNDTiMaLN5GUrJa4JABozZuDz+LN9Vz+j0QTf
 EcwmGbNbHB1ke/VL4NPo5td+XoSLX97TsUtpD4G8kHXjRfrmrM58BQuupurqMVCpmjIH6aq7dzT
 elUSkHBVeuNme4rAMfQ0cr+3YKolUE1kpruomuaWVQ5h463Kq7E7p+pHUYt3WkKzS7tKK0YMZWb
 hTjld8PyVkplmc2GjT5u8g/cxAoWlcPPYPqA+pObIViS2YyZlQQVdHzy7N0h9UMuWN5j3FlImdd
 6aN2EotDttNJLdQ2rHS9QHaS0iacg4+oCuxPpK8SjpIe0GeIKNE242MLHczNyMfXr7qGYvat590
 WnHzck5z+wHaw5WnlcL7J1j640NwG8l59AG81gvBhWeg28Lm5OuWXH6nFg9fP+vvULDgu466Bz4
 5YVRe4+aPPl9QQZ4oFZDnM3fgVu0L5gDTxN3CFnLR5d/+Ve81Zyz6q6LFnsGlmFM2nTbsM4sTRc
 QdgB+4PDtWHMXXWNL3jeDz0g34tpQNttJgySO5xqw==
X-Received: by 2002:a17:90b:54c3:b0:398:d6e8:f84e with SMTP id
 98e67ed59e1d1-39b2612ecebmr822484a91.9.1788461149238; 
 Thu, 03 Sep 2026 11:45:49 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b25f8d2c5sm350766a91.2.2026.09.03.11.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:45:48 -0700 (PDT)
Date: Thu, 3 Sep 2026 11:45:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: liujie5@linkdatatechnology.com
Cc: dev@dpdk.org
Subject: Re: [PATCH v10 00/48] net/sxe2: re-align with reference and fix
 review findings
Message-ID: <20260903114535.09e541c7@phoenix.local>
In-Reply-To: <20260903015349.161757-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
 <20260903015349.161757-1-liujie5@linkdatatechnology.com>
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

On Thu,  3 Sep 2026 09:53:49 +0800
liujie5@linkdatatechnology.com wrote:

> From: Jie Liu <liujie5@linkdatatechnology.com>
> 
> This series updates the SXE2 poll mode driver (drivers/net/sxe2) and
> its common library (drivers/common/sxe2), fixing issues found in the
> previous version and re-aligning the driver with the reference
> implementation.
> 
> Changes since v9:
> - correct the commit message of the link state refresh patch: the
>   sxe2_link_update() call in sxe2_link_update_init() is kept, not
>   removed, and is now conditional on a successful link status read so
>   the initial link state is still populated at init
> - return the error from rte_eth_devargs_parse() directly on the
>   devargs parse failure paths: that function does not set rte_errno,
>   so returning -rte_errno could yield 0 and let probing continue with
>   an empty eth_da after a parse failure
> 
> Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>

Applied to next-net

The older queue stats mapping is gone in 26.11 so it requires
some rework.

Patchwork was getting confused by the mail threading.
Not sure how you sent it but the easiest way would have been
to thread reply against the msgid of the first cover letter.
  
  $ MSGID=20260818021518.2922515-1-liujie5@linkdatatechnology.com
  $ git send-email -v10 --in-reply-to=$MSGID \
     --to dev@dpdk.org --cc-cmd ./devtools/get-maintainer.sh \
     --cover-letter --annotate
     origin/main # or *.patch
