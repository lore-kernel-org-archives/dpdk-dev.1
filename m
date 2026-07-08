Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAADC43458
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Jul 2026 15:03:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C400C40268;
	Wed,  8 Jul 2026 17:03:40 +0200 (CEST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id A484440265
 for <dev@dpdk.org>; Wed,  8 Jul 2026 17:03:38 +0200 (CEST)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-51c1372f84dso4579081cf.2
 for <dev@dpdk.org>; Wed, 08 Jul 2026 08:03:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783523018; cv=none;
 d=google.com; s=arc-20260327;
 b=XjxlMBfNUAV7hPcq/m3vL0tVpM1K3K2+dGXoqp+T0KMTps7kgXCHZIqAFJo5PmZsIq
 h+kRGFX8W2KNE5ubI3RiSkuaA3C458Y3vEz6aOZGcTvEUOwqhxVE40WG2muK6Oc8rOAi
 6V3WW95009Kv+BPVzkJHHXeWtWjgyIaVtvfyxIl+8rBEZHVW5mlXZnb+3SeYUEqqiYHc
 zct+f+b+5JoT6FaclhtAtWvCYTgrJVAOSRnqHqJUp55FrVF8IrQk5A24U/amYTTrOZt3
 3FEkYiisIxXqMZtI3KGKyb9Y/MT6EtwpQRr2LKqY12y5rKsPQy3YA0z8duK7PnXTrqeu
 pIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qDn+TbDNe5/2EeFYuyTT4u9EEaVt2/KuhUBu1DMoSak=;
 fh=DYLFf6xRREw02z1stMDae5pROKvlyuVGUPcwvA1Jj9A=;
 b=cZ91xtqQPCNZFH1T4gRlkQMQ32nrTuFC3r5KYwjfTRr5B4XjZRE0uga+TlQKJ4iF/y
 DLcNjqOeQT5fCz3TpUHKbHJb+Sg0nG9xNGelKmGPtZPDmwZhYYqz0IOzyHcVvqlQeP3U
 RdBPmtw0oeJY7fD1Mf2RvVEChRE1ucPeC9+jSGWvhs/+qTsdwGAP1gLKKhx9Rt1oC9Lv
 LDIamMCAIzWl3HsXvxIrlV43K02yYUjxXHOSAmN4AHm9GOF5wM0Xd7to5COpqA2dx+dm
 6gCHpduynwWov89I1pTsU75oIrv0w/rKfQwj1oMB03MpEElQQVaj3fczxiBtXlZsgQBL
 FZbA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1783523018; x=1784127818; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qDn+TbDNe5/2EeFYuyTT4u9EEaVt2/KuhUBu1DMoSak=;
 b=N/26/OBax+tJKFHaT4yb3WNXzsuT+ubo+DKfSSyYEt7dX0fBd3ZlZhMo/QWO0t6sQO
 gdxKDOeZiENqpWHery+ZssRxEVEB6sFzJV7ldR68UBZ5yVqFNEAyZv3WHkm4R5W3vCfM
 UC6Jo6P9iMTe2mHonWvQhDCFaDsawQDIEZr6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783523018; x=1784127818;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qDn+TbDNe5/2EeFYuyTT4u9EEaVt2/KuhUBu1DMoSak=;
 b=BnZRUzYMkW35tcPif9dmrn8ygrS2BCcHQewGs2I52qp65YCF3sX/IskrPWqq9BGox7
 JebGFfGmg3iCI+OScw1Wh2s2XC5KDowONE4Y3yzJC0soS9UlqaKEOxrUbYv4uCQeJH0K
 iKKWj4s/XNFhPCx9HXSV23trjWrRVb5E6D6GQSSPc2xrw47630FjtHPEnFl5nJrSse71
 w2KwdSurEAhYj5iOApyn8WmfKSdO+FfmjpGwdwghOmiaPzSWIYAnrDjUge5gmQ+/khzr
 XpH7tYWgH8q8Le5iTUlCEKjgT+scHRaovYlwPga9nXEyarziPmobWmz0kqMlQxRadA7u
 qsbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWeR3XI7FLFyB6XfR3WzlzaPlEKVx4pQnKlajdUAw6FzUA4MD62W2iHDlRuHvwQjfu/C4=@dpdk.org
X-Gm-Message-State: AOJu0Yx8PX/vGP1nMKVoVL7G++9FGuLxdu6kRC6X6pyoRvXUjuIO7dPS
 +7v4stxRX/klt7TdAaIuNDucgUfSq/gRxyokz9Rj+MByJdD4rASKrYKMY5RJgd6D+yJT9geo/1/
 LE0iw1Alep9rLjUNz51bqvjxqZnVb9T+JtyPTft7jhw==
X-Gm-Gg: AfdE7clRAZOhoN8qqeNHEph8O+htl9j9rvgMZsKZDNlv7mibx/Lmyy0sIQY4e1pc5lX
 1p8JRCdHoZanKHyuvZsuLDYOz0L/4S054l8BTfHJh5YnUeIsijyEAaJqxfnUQ94hH0dO+ofZ0vy
 3Zds4cKlkfLwoLDhv1z3lbJFLnySYrYNLug4ytoMiZKgFMQcFYBX0zJCZNfJV3Pv1p09keHv13l
 2rSOT8i9lSkcZbL5w5/2ACFGsPI8iG9dMn2tUQS79xSnopeHwHj0l0j+yIdFhh0/oQbbz/MC5AI
 wkbnFBCm/TZL7jOqbrQRrbMe02yMxM12bR6Zty3tytfBP7UJK9aA372vxHGhHZ1PgFfjEsCXhAZ
 CeqXgVQlVC6PQR5dT0bND6ZDaP+UnNA1/clMMv//anFKA9pbM9WwtsrRaqqWoHQ==
X-Received: by 2002:a05:622a:1b1c:b0:51c:478:3299 with SMTP id
 d75a77b69052e-51c8b2bdff7mr29644271cf.9.1783523017762; Wed, 08 Jul 2026
 08:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260708141309.566874-1-knimoji@iol.unh.edu>
 <c88474df-8cf0-422b-8b22-1ce65a0084d6@arm.com>
In-Reply-To: <c88474df-8cf0-422b-8b22-1ce65a0084d6@arm.com>
From: Koushik Bhargav Nimoji <knimoji@iol.unh.edu>
Date: Wed, 8 Jul 2026 11:03:01 -0400
X-Gm-Features: AVVi8CedtQbIB_Sz8Bj1wJCx9NQbHoUm4HwwbrQ2WJhzQmy__W856jJnRHo47D8
Message-ID: <CAKYPG+xAWQTsaaqKj_Ai53jijikrQh2ZW+CQNhBgkk3fsK-XoQ@mail.gmail.com>
Subject: Re: [PATCH v1] dts: resolve new formatting error
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: patrickrobb1997@gmail.com, dev@dpdk.org, abailey@iol.unh.edu, 
 ahassick@iol.unh.edu, lylavoie@iol.unh.edu
Content-Type: multipart/alternative; boundary="000000000000ec37b606561acf29"
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

--000000000000ec37b606561acf29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Luca.

On Wed, Jul 8, 2026 at 10:54=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.co=
m> wrote:

> Now applied to next-dts to the original patch
>

--000000000000ec37b606561acf29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Luca.</div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 8, 2026 at 1=
0:54=E2=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@arm.com">=
Luca.Vizzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">Now applied to next-dts to the original patch<br>
</blockquote></div>

--000000000000ec37b606561acf29--
