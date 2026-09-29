Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010D7C9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:37:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AFC942708;
	Tue, 29 Sep 2026 15:37:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 37B3640ED1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 15:37:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790689070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fyqbkr/MJYGmMtK7/+26niVU53PVBXvxKMNslricsYM=;
 b=IE3axTkZukKc7vuLYpBeNhIbx4PO8Y0qyRNXfBWuIyUkjS1FnahKMNUUllMASR1132RQcQ
 m5f8dtdg1WeTRnmDGsS7gzrPvY/AMMJhb5eJZwBk5wzrvhWrc9k9w0/C08TKQNuLU7Qfsy
 oogEehe1U0zMT2PFUjlLDQYh/hF8/L0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-ZOSUhe1HNNiHc0OLldLBXQ-1; Tue, 29 Sep 2026 09:37:49 -0400
X-MC-Unique: ZOSUhe1HNNiHc0OLldLBXQ-1
X-Mimecast-MFC-AGG-ID: ZOSUhe1HNNiHc0OLldLBXQ_1790689068
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a0f55a3941so3360974a91.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 06:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790689068; x=1791293868;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fyqbkr/MJYGmMtK7/+26niVU53PVBXvxKMNslricsYM=;
 b=CsiO+bGAL8KZpPBsMVUE0oSKPLUBpotO9V7PYsOu/FvEFrJNQUPQFvZEaAT/W3eeDO
 oXVmazHDhJBJt4NIMTBp/wZ7ll1bHKeGYOSh8yfW7MoSYAc98acTG/lpC/Vx32vJkD/8
 v7EP1jbgNKbNG84+BWvpChCjKhXWejon/tzAHQ+lIA4cip243ZJ1ImNR0hGyP7UzwaYH
 TJGpopA8vULaiwC3GM3eWmXGIDxVJ8s3taaJb50F0/KmihztcbiRqUyjllFNHTZmNnFy
 gI+GH8ycgNebrq4YGK7dQqEJYl6MPOjMLuK/jJtc2hrkMqRMFOk7J2eE+kDcH/NjDtDw
 PLfA==
X-Gm-Message-State: AFq9FYIoy0giwLK00GiI0a/KPk/+qatTE8RjZx87Ub0XiGtDT2yDA7ep
 6DWs7jrJdzqyapHoVhtvF72dFBvQpuS5lNdf3VRxM20iSfip9KmBcZj7t3I1eobGBokUhCxKrid
 //8LCry1BJcPWyBliEcDfLT9WCz8u34pcSoeVkeFgwdhAV6EcWf58tpIP8IZpUFEdyAKGWEUJFx
 ij7qtYRvb3wBlGnVhrT8g=
X-Gm-Gg: AYBFou2EunwK5Q/FIE0EzUkYO2QjeRFReAfVEbm4de0bzBGXbcgEX8Kx60k5MUp2ohj
 Djck/YclDIpdbnm1USPtmzFaY5tTGzzOBTG/mtjS23VmBDRPrnPxDzD/YPbJfE8xjPQ74nmmdax
 jhgip8tK19PIjZihMpce4CHO4kLXb5IH1XsWMdEhxy3V+MAxA9k6E3t/NeAmPvUfNL2gc3nPLnq
 i942pwx5s3xfItxD1SIQ78TNrU/xlMnZgQUgPKErf8nDo67
X-Received: by 2002:a17:90b:4a91:b0:3a0:bf26:f24a with SMTP id
 98e67ed59e1d1-3a0bf26fc15mr10774627a91.45.1790689068122; 
 Tue, 29 Sep 2026 06:37:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4a91:b0:3a0:bf26:f24a with SMTP id
 98e67ed59e1d1-3a0bf26fc15mr10774601a91.45.1790689067588; Tue, 29 Sep 2026
 06:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251205121301.3443561-1-bruce.richardson@intel.com>
 <20260916132403.1040252-1-bruce.richardson@intel.com>
In-Reply-To: <20260916132403.1040252-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 29 Sep 2026 15:37:32 +0200
X-Gm-Features: AclHuK8O_EWhslOWqXRNpVCEyk1JvGB2Q3e353sbcNN1So0LcnA8pmsD4bFdhjI
Message-ID: <CAJFAV8w5iRYwSH5ei7wxmQL2j7x1cHCdeTPdi2o26fNBMxJafw@mail.gmail.com>
Subject: Re: [PATCH v2] build: bump meson version to remove warnings
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RbUmYjoyKtrOSr_yCbBr4zjVptgYMon2N3ksAyXWkYA_1790689068
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 16 Sept 2026 at 15:24, Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> The build of DPDK now uses features from version 0.6 of meson, which is
> greater than the current minimum of 0.57.2. Although these features are
> non-critical, they do cause warnings to be emitted on build. Increase
> minimum meson version to 0.61 (== version in Ubuntu 22.04 LTS) to remove
> these warnings.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Applied, thanks Bruce.


-- 
David Marchand

