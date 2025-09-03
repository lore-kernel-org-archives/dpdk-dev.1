Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02615CA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 09:51:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FE5540B98;
	Wed,  3 Sep 2025 11:51:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 6EBA0402CD
 for <dev@dpdk.org>; Wed,  3 Sep 2025 11:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756893066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Umhu9yQ5jmWc+ZINISVj4ROpgW5o+UdBR7pFdRy6Oec=;
 b=QSampuTpxPD0IGjB2r3Q1G7hVyqZrQafWaPszHmMavs48WprHO++gAiiWA9n9OF7GsmsHl
 00eIFVjB3tICpsRPnfI3LwicBF7YKcwCwAPf5OOde/t+aY6hr+QN0eQ3k5zBgc1C2K0B++
 BgkKM9miE5n/pir1jv/mggN6eZzTy30=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-QwMnR2uvOwS2IMrfSZ5SXA-1; Wed, 03 Sep 2025 05:51:04 -0400
X-MC-Unique: QwMnR2uvOwS2IMrfSZ5SXA-1
X-Mimecast-MFC-AGG-ID: QwMnR2uvOwS2IMrfSZ5SXA_1756893063
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-55f6a515516so342224e87.0
 for <dev@dpdk.org>; Wed, 03 Sep 2025 02:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756893063; x=1757497863;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Umhu9yQ5jmWc+ZINISVj4ROpgW5o+UdBR7pFdRy6Oec=;
 b=sR/i/BnP/qIK70H71a2OBdW+luQS+4o7lTBEiHd5DYyR6lf0aD5pIZ8Qjo+T3V+qwl
 hUtjN3vFZAaKl/3vpdwwiGASW9Lv/OGucHkfaVnJs0BDyfv2Nhw3SWoJ/lVFVR/5B43d
 ftYXclGjpbGEc33NV13P0HE6/+XVB5Xdda+pmtLSAlh7RLlUCMnybpCufMKhwEKT4dUO
 PG8JKLdgBHdfLyFlYxLPlm7vaLRC1FV6NWeIzNJuTIZA4bn3C7EWoWCQm4DJeK4lHJzJ
 peYtz1X5GTmV+B+hkai8ppWLPkVnTl52wYg5twIZEdYp+y5m2DDTlqRsNuTEODeeS8GE
 sgIA==
X-Gm-Message-State: AOJu0Ywg94ZLZle104HnfQQ2L9+qaRP28NXaOaR2JF7GBwUlrpubH00Y
 XUy7eNApQ6RXOYATXH3FZuKHKWnstRP+4/S18iyquNMgbJjDKph0wj1OJXLMu7ZWnq7ZFR6iqDG
 XA6jcta7HWOx1+ppVISLISlCDUnj8JDq+sPjthc7/B9kvra5PBv3rxmSl97l29L0+nnfzsrpZju
 K+aFvp/mhcdvRVfoLmf3M=
X-Gm-Gg: ASbGncseo7rMkfOa8EDCDU/0dFn0/nDaLRXVKpFpHBK/57M11Le0JG/fNRLCcVE/yoD
 hSXURPlB6uPMkNlnP9bnOGZDyrkir7YtrYdhM/D4IgrbJTj7dwdFQfMAUA2pNJObYzvshrQVWQu
 gxjkGzblNzjbKTbdBY4+nvwMc=
X-Received: by 2002:a05:6512:3d11:b0:553:29cc:c49c with SMTP id
 2adb3069b0e04-55f708bffa9mr4733024e87.7.1756893063131; 
 Wed, 03 Sep 2025 02:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWK7y/Lchap8iNSwkeRPY4QaIsgPnOsOqvgW5mknKCsrZOjPJodrK/ht08+3UfBsBQMRBwvXKOiqi24nYUKLk=
X-Received: by 2002:a05:6512:3d11:b0:553:29cc:c49c with SMTP id
 2adb3069b0e04-55f708bffa9mr4733012e87.7.1756893062710; Wed, 03 Sep 2025
 02:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250204160739.1603197-1-aconole@redhat.com>
 <CAJFAV8yogQtTMPOpxJVh6mEKrtbBaKm4j-v3EN16qV2GbSqAqQ@mail.gmail.com>
In-Reply-To: <CAJFAV8yogQtTMPOpxJVh6mEKrtbBaKm4j-v3EN16qV2GbSqAqQ@mail.gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Sep 2025 11:50:50 +0200
X-Gm-Features: Ac12FXycFtdiIwJ1zjr6GxDEOTesQX2727laKTbi9V6eHWxLj79HTBi7LVrteAM
Message-ID: <CAJFAV8zSejTO0UHmXVpG8Npx4S54bst7KBjSyfAjCz05mgV9jg@mail.gmail.com>
Subject: Re: [RFC] ci: Add support for Cirrus-CI service to test FreeBSD.
To: Aaron Conole <aconole@redhat.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, 
 Patrick Robb <probb@iol.unh.edu>, Anatoly Burakov <anatoly.burakov@intel.com>, 
 Michael Santana <maicolgabriel@hotmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e2uuVIkgPefkCbkSE5H5BB5BHK4qrs-_fuUbadryq8w_1756893063
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

On Wed, 3 Sept 2025 at 11:49, David Marchand <david.marchand@redhat.com> wrote:
> The check SPDX script should be updated to skip the new .cirrus.yml file.

Oh, and maybe update .gitignore.


-- 
David Marchand

