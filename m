Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DF9C5DF7D
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Aug 2026 19:09:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54BC240289;
	Fri, 21 Aug 2026 21:09:50 +0200 (CEST)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51]) by mails.dpdk.org (Postfix) with ESMTP id 40BF24027B
 for <dev@dpdk.org>; Fri, 21 Aug 2026 21:09:49 +0200 (CEST)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso1509180a91.2
 for <dev@dpdk.org>; Fri, 21 Aug 2026 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787339388;
 x=1787944188; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A6xIIv445dsgXJyH8Yxz3VSYfLUXw5k2E4+/Wb8K3rQ=;
 b=Wyv+c0FJq7HekPYo3RrjVcv6CxOJI7CQPhkrpifWFpG5xi4B7c7DOo+g3qjOdWE7S2
 f+pWYSjJ90iAZ8SwNkSnS7tr4C5ZdZ9kBc+20RqRiT/MfNwZiIh4BL7AahTY1mX0jshF
 9zsLjJj2LyNZcJOHvsFu6sYo+RZYqr1occRpRsABDHBqaYR3ENEzmtWakKraKjkV65qS
 IupSYYLCrXdj9zaMzVaByrQuThbrj1bostHh0aiDQ75kN9AQWRe3NHpXEB8m8Xdgs4m7
 /D476BwToletZphshX0jhArSrXCgOd73YmG95q5/sS2fz2Wtk3WyG/kiYTqULPu0XyvF
 g7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787339388; x=1787944188;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A6xIIv445dsgXJyH8Yxz3VSYfLUXw5k2E4+/Wb8K3rQ=;
 b=oKulCQMgJwh0XtEo1ZUN8lIdSHyUcOBABIeNAnsi0fNlyw3cXbX9xhSwyVnRyKNdr1
 Iki91jVlZI9glHAFW3isTInsO8C9Qc/ej60EWuqM2n1vd/WNJeRWNmgneTWMyIquHOy3
 nzRTUleprVwT9qoDbtDs6+g0H07g3zmOORT4I0ak2iFPiNxPeOtr9PTa3IGhQPurz6kO
 YuZwCl8lYWAQPpfJ+9ZwXiRu1U7VHNKDjOClOrF8Uy67QDQNJNhC0BepoqlZ+vZURjPz
 +QtqgzO2SxpbFPZXHgaJooyksXhykHXpdQgA5dieufaR2OM4pVN918A32hzcdRmVxKBN
 lmsw==
X-Gm-Message-State: AFuF++lqsvJzy2UiF4RaNDf6PP+OBQTWIsX/eGXiiOQ5ws6MZl8Dmcm3
 bke8BWrqGBxdVUiV+OPn/HgYWhh57MhKb9lhh2RoXGbDzUVj5YetGUhiuqolxG2KKUI=
X-Gm-Gg: AR+sD13J/xWhD8kThCFxiypBBJ/qKrafkSRMufzv5vYyWR1DxlqQe+XHQMh2QnhyrVp
 2TyqVDsgNRnRd2rVfIEZffOkLUnShwGrZLGzyoLEDaLeeQNRsqvzU07R830LfD9lDEYedHnjXRe
 Fj6BzMAc8fJZcOLyKq1zsZ2MmOLLgtuHu72LA6fR3AIx9w8dbJ9TmtBuuiBRhQTe2wtg/wVwolf
 e2v8RaL8ZrOmz8uH4FRuOp4qpTARzP0ub8Ne/clQlZCulX1fNxegRPWW8VTOkee7PLW9WRYAIy+
 gHVYzXrOy/Dvq8Q8Up6nWXVvUtlRvEj3qbpfBhz8Netjsi7V9ehH8QY178er9mX8ea5XN6s7Lg9
 0EQgJKpCQmz/VrgBLpkmDwzBEvj50AqgIl2gKNI+/bvqBLi4mHCQnMPdjWYSXXUylN/mbiNxJuX
 gr3mvma6LNavn1Rzgq1/EVYK+O8kEe1+gXimljpVuIjJ2HIn8Wn8+V4c7sWIZ5MB040le4G+C0z
 1DqW1UeoGfdGtw/UTdAtSXNLInzLA==
X-Received: by 2002:a17:90b:1801:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-395df25998dmr1151471a91.11.1787339388002; 
 Fri, 21 Aug 2026 12:09:48 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e14dc436sm250232a91.8.2026.08.21.12.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 12:09:47 -0700 (PDT)
Date: Fri, 21 Aug 2026 12:09:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>, Roman Zhukov
 <Roman.Zhukov@arknetworks.am>, Pieter Jansen van Vuuren
 <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, stable@dpdk.org
Subject: Re: [PATCH 1/2] net/sfc: fix shared adapter pointer set in
 secondary process
Message-ID: <20260821120936.3306cec4@phoenix.local>
In-Reply-To: <20260820130314.12251-2-ivan.malov@arknetworks.am>
References: <20260820130314.12251-1-ivan.malov@arknetworks.am>
 <20260820130314.12251-2-ivan.malov@arknetworks.am>
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

On Thu, 20 Aug 2026 17:03:13 +0400
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> Add the missing assignment to preclude NULL pointer dereference that has
> happened in the context of the secondary process at the dev close stage.
> 
> Fixes: 5313b441d8ae ("net/sfc: separate adapter primary process and shared data")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
> Reviewed-by: Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
> ---

This is correct.
