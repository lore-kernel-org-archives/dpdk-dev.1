Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5C7CA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 07:32:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 445C34066A;
	Wed,  3 Sep 2025 09:32:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 8655E402BC
 for <dev@dpdk.org>; Wed,  3 Sep 2025 09:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756884764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9c03VyjSTuN8HYPKqYMIoi827qYQRRI0VIgVHf+OZxA=;
 b=OtM0IOlBH+yhlHi51AVpDh9BpHhGkbPkIBnsMhSWivUzjQeEHbA9T+2GU3G9LqpYht8hfU
 m1MDTP+6YGKBtmTskQo0mwlB5tO8kHv0dD36X+hYgDU13ptRTKWilbyiQB5LQz5toTCteq
 oeq/++pAKTc9ddrbPP0rRezA8Em/YnA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-R6xqhcnLO5-L-3jy-aoljQ-1; Wed, 03 Sep 2025 03:32:43 -0400
X-MC-Unique: R6xqhcnLO5-L-3jy-aoljQ-1
X-Mimecast-MFC-AGG-ID: R6xqhcnLO5-L-3jy-aoljQ_1756884762
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-55f75effcd1so2814638e87.1
 for <dev@dpdk.org>; Wed, 03 Sep 2025 00:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756884762; x=1757489562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9c03VyjSTuN8HYPKqYMIoi827qYQRRI0VIgVHf+OZxA=;
 b=g4VfymzXbpnArBzvoX9rOctVWmDhxyEvmMBVNwlyEIjU98rUyMztqGDmM26z5s1dZr
 MBtbdf5mr6MkcSHMb5HpZVfloVItCieHU220mBuUAHOVSEqxuyDFRlSUkEdVHim265XI
 nIJAQvo49XbeyRKGrr/rv3HKHaTJQOeu+7MSq6KL/c1Pe7bb/9Swp+oNcfQe8gRj+3v8
 cDyKn02MjMBiWtCbsClCCKlIrfs6H2C8PwEbaPkHnqSHf8++yhaFKqV71RIOkJfYo/+G
 g7ewp6fwEay4i4RjJEvJsRzTCMBS6PPlHLIW4vWTkLI3t/P0NfA6uT9AM0wlZtCAsAQL
 aKDQ==
X-Gm-Message-State: AOJu0YyiPUNE1pG0z0kARvlO6UrEi+lbBCXFQLzmZEs1QxjSMeIazrjp
 HVfU5pn6bzEqsB1ffxn/CebQ4jZrFgBq5V+r353R8IP5VAxg5zYU5H0Em5bR9/tx0iBQIewjY2b
 TuScQ6IuV4TmRxKgS9MfTQlj/xvBtqWIcpnHHrLAgGdMoHdCKOKHF59QLbHj7udgWHpr+X7UxIL
 xbwL26ruJdWDf6TG15NVM=
X-Gm-Gg: ASbGncsQuZL9h9VFx6uOAK23pEZyop+AUzJyonK38mng40SqUx+9nJVgO5iRXeiWhvT
 lANcuA+0Hf4fMBp5W9vWuNfhxBpF/Ipgh4RY8aM/DKLsz7ruiO0+bcO9ytLyzncttPM1eK61bKc
 W7lymyeTrbCyPOTqHOPlcAoDw=
X-Received: by 2002:a05:6512:3ca4:b0:55f:6831:6f01 with SMTP id
 2adb3069b0e04-55f709bb3d7mr4101288e87.40.1756884762098; 
 Wed, 03 Sep 2025 00:32:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkbtoP2sF1yk8RV+Se2kKKygojBpCW+tGd8fiiAGCeHkDJHW5Fkz1ypNqI9oe6CoXGHCZPPmEoLO8EjTpQZgE=
X-Received: by 2002:a05:6512:3ca4:b0:55f:6831:6f01 with SMTP id
 2adb3069b0e04-55f709bb3d7mr4101275e87.40.1756884761479; Wed, 03 Sep 2025
 00:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250822115113.1313226-1-ashwini@wisig.com>
 <20250822115113.1313226-2-ashwini@wisig.com>
In-Reply-To: <20250822115113.1313226-2-ashwini@wisig.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 3 Sep 2025 09:32:29 +0200
X-Gm-Features: Ac12FXz3Cq9uLnV1hBYtVuUoFj0ncSpDUBKt3gh3TZq20ZvVRvKUqDSGfG9FX8I
Message-ID: <CAJFAV8wqC1PpVvRoxdRpb-8v5FY90KOfKuTGLL_CvbUnpdjsRg@mail.gmail.com>
Subject: Re: [PATCH] vduse: fix typo in struct vduse_iova_info comment
To: Ashwini Sahu <ashwini@wisig.com>
Cc: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uO0yXJHn7J8GGt0z6caIA6TWUBj4xnV1F-4bDlXS_WI_1756884762
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

On Mon, 25 Aug 2025 at 14:08, Ashwini Sahu <ashwini@wisig.com> wrote:
>
> Fixes a typo in the kernel header comment for struct vduse_iova_info
> where "IOVA region" was incorrectly repeated.
>
> Signed-off-by: Ashwini Sahu <ashwini@wisig.com>

I would rather fix this typo "at the source", iow in the kernel.
Otherwise, this change will get reverted when a newer version of this
header is imported.


-- 
David Marchand

