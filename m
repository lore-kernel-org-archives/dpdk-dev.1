Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76DC88E6E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 16:15:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 648DA40E21;
	Mon, 14 Sep 2026 18:15:24 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id CEA2740A75
 for <dev@dpdk.org>; Mon, 14 Sep 2026 18:15:22 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so2191798a91.3
 for <dev@dpdk.org>; Mon, 14 Sep 2026 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789402522;
 x=1790007322; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/2uW4LU/Z0OZh0t76vZ9hpi5O2jqqTKCsGNx8C0H3c=;
 b=auU1e4pq+9zDS/hR5sQQafAEm+4iHch8C8BOF3UmhnIBp572SBdeqFl2MUOjSqZTZm
 yR+LOm7hs7Ad6k3eZAiJ8ZB2NNorEB6ZlealG49ghpibcWJcy0IoZ4K6cfLt97AxBIfn
 gWB7oJHFiOwwQBdHa3o/A2maz07Q7QMclrCiy5vohdwkySyoTCs+3ZnAPOwQjrWPZIhO
 zoFmLD2aOPayR/FHT8RuCOb902iG2fLikoBBzspWSaoYMHLXLuxgTwCoDy3kLhFbEkaC
 PJMhMwuZzR/Y3RHgYpXaPn/AEMHpk2YDDa6yELCak02N/xcKbniYCNFhNEitfVSoAMcI
 AduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789402522; x=1790007322;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7/2uW4LU/Z0OZh0t76vZ9hpi5O2jqqTKCsGNx8C0H3c=;
 b=GbzWzsmFxhvpZHDIV1awjVN/+2T3ZMcWjhs0AdF+X+mQqmMippSDAFwc5fgTJ84HDB
 0bZtQe+3NXw9R5zqEY2UA6vbPdvKGPfmRc8g/MhYyrX4PCXosZcTew50aMeWYk2rhtzo
 K/hYfGtoN86tWhPYd1wOs25p+lNSmg1cHAg18lVtHARYDqFD+FRyPC3UE73QuHMnKgQe
 UvEIQGdc8vojxZD/7F8N78+PuMKGB2tJzwPmXQguGI9ckpzLoRMuP/4tAyFaSF57xAlD
 FDKtULl2hEtGmcb4iP+GIhWfShjACv5AEko37yAo3rKKB62dP9fwWfeg22WQrIkOyv96
 c22g==
X-Gm-Message-State: AFuF++neiwz2bPvQYNtWZKg4UvniXcMKoMqqCYSjQlv6V4lIwW/M+yQE
 dB4e+HThKiOMQY4KcXAZ7Pcjrqn6i8ubGwTpOUD9jJyb7gII6kT+AB7xE3NcZ34Oc6nz/OsS4fC
 DzlqF
X-Gm-Gg: AYBFou2lIRiQY1VU1GfmMTgqNJ3/kEcfIfFpbVKNXsAG8fqzCclu4zXiArZ51G3NJr+
 tGpSZKd8B13ZJ9GDWJZzo80o6+z2VzkJJPhO9alH1zPTms7E+eRdENSDXuw5fxiR7kI+k3pYTQf
 n+UKFwKk+mz6ANSVlSXi0P0Tey4a4OR3jLZ/sCTmQezn4jcJqKDWtRNZQbjdM7IPCPJC/XCUIQF
 pYMglFi9yV0XoY6A5pkPabCwARtlqloS4FRS2rAVfhPsSQ3uaqBb04qZKGHwM06bTIQQyvQfQlj
 zxqNnpYRt4dyA2s1D2V1XpKWxvgJB4Ta8EY1u7Foa03TemYc5kKK7+gLF+ZKylKDEV9+PeMXAWx
 yoayKgY+SeDEO4aqpX0mLblxmYhrHMRCidwHQyJYgzatskC5V0jFpnYY5gw/a1qfb5BAvadDIEA
 E7VrdaFh01zl6v428A4hW9LAkQk8NlQUFewUaHFrvVc4c0gBUPOxHavSaLqc5Gjri1RbqqovHds
 +ALsmcz4AMs24c0UcYfe5qIFNmIQxQbYp/RyuSg
X-Received: by 2002:a17:90b:3d46:b0:39b:61f1:8032 with SMTP id
 98e67ed59e1d1-39dec09350amr6670432a91.16.1789402521799; 
 Mon, 14 Sep 2026 09:15:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdcb618bsm174507a91.5.2026.09.14.09.15.20
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 09:15:21 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:15:14 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 00/22] ethdev: convert experimental symbols etc
Message-ID: <20260914091514.4d317e9b@phoenix.local>
In-Reply-To: <20260901203217.1485915-1-stephen@networkplumber.org>
References: <20260901203217.1485915-1-stephen@networkplumber.org>
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

On Tue,  1 Sep 2026 13:22:59 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> The DPDK policy is that experimental status should be short term
> with the expectation that it will be removed after one or two releases.
> A large part of the ethdev API has been left marked experimental long past that point.
> Several API's have stayed experimental as far back as 17.11.
> This series promotes 119 ethdev symbols introduced in 24.11 or earlier.
> It also cleans up comments  warnings on structures and inline functions.
> 
> The trace point symbols are left experimental on purpose;
> trace infrastructure is intended to stay unstable.

Applied to next-net
