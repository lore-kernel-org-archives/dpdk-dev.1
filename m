Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB87C5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 19:42:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F0A784026C;
	Wed,  4 Jun 2025 21:42:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3FA444025D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 21:42:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749066132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8JcpHQ5kZt99wH12k4ckobwE7zzW69N/lO3YFgmuGc=;
 b=X0vIczX+ksDu/W/twAgq8gbcSgux9YIPuVy7RPsuiyLSAObmPDTu5m5+T0KCbhla6rg45L
 h/j26A9RSkWm91QVYAud5DhAHU15WS1nuTR6Fn52p/D9vCbdTMd01mXgRJL7D2ym/uYy+0
 ERdXmOxBwWKjNJOsI7QDzR6g+ydQrFA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-y2LEFCDXNDGsQSdDxD2bCA-1; Wed, 04 Jun 2025 15:42:11 -0400
X-MC-Unique: y2LEFCDXNDGsQSdDxD2bCA-1
X-Mimecast-MFC-AGG-ID: y2LEFCDXNDGsQSdDxD2bCA_1749066130
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-553266b8574so636515e87.1
 for <dev@dpdk.org>; Wed, 04 Jun 2025 12:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749066130; x=1749670930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R8JcpHQ5kZt99wH12k4ckobwE7zzW69N/lO3YFgmuGc=;
 b=jD6VYeAKIOG2eBzcWbIK7phfzOpI4BrMyAm68VZqj1eVqCXP0mfT3sDiQIciuTtuia
 lPI40dypZ/Lm2jUwGutfwP9mLPu2hs2woNpOTxZYul0HvnLc2EBzP7A6AM2zHbMFQok6
 LhgU6T3+L+MXO/5ZB5viELSzC88/WrZa7FF9L2MXAYzyX1cip/IO4hJrK20ggpSpRtiY
 AVbj5GauIVNnOPvE/h7aADqB+Mf66Ew+vDeNSpVdOJ0taUfU3YRQ8jn17odKG7/WIzJE
 jJNwn39pfx8m4uC1rry7gQbx5ULhV8DyQO4EcG6tvUk6HeajYCjRIfU8OYoIvcLaiyJ3
 l+lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6ul3KaeJBPLu9kZas8fM5wow9q0Zx/dzJo2L7P3d/HWtDVgUVNnXhZRXc7vWgI9wA2Sk=@dpdk.org
X-Gm-Message-State: AOJu0YwQHDl+RJI1iKhiexjWUJn7m6Zvky5z1F0Jey3+dss1hPmollaX
 4cwMRyifFlIcX5jIh8mywbeEa2mUhS6lzxerHt+JVBsUJXSRvUt0BQu2UijH7dRPFljttYuD7ir
 s0OEdUWHeMtVmiOW9bE8TB4wGPLaoOiCSQN35hd+N7v9AalFNLmCV2514nOy11cBsJbIAvDvHCd
 4GkOZZqaRs1D1/7t8iquo=
X-Gm-Gg: ASbGncsoRyiQ9N9/3EFCPmA63Zqtlem/jaqx4dobudRVXwSVUHO6C4ChYP9ubYVTZmv
 9JfKJvu+tiA5Dbz9gCZQXEBccDX4n2kGwsr19HDP4hr6CoMfnIiLZWBFN1rd78fK50eYr1P9/Zu
 bOwrBXTg==
X-Received: by 2002:a05:6512:3404:b0:551:f166:bbb with SMTP id
 2adb3069b0e04-5535d8f4e35mr247761e87.13.1749066129658; 
 Wed, 04 Jun 2025 12:42:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf5pEbuq43wtsDDsF281LlLupwDQ6prxgOUq2yZYWLUUa2tuKkguXnR20LCKsHiD3s+ZRGWojv0ou5mcwL4zM=
X-Received: by 2002:a05:6512:3404:b0:551:f166:bbb with SMTP id
 2adb3069b0e04-5535d8f4e35mr247753e87.13.1749066129263; Wed, 04 Jun 2025
 12:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250402093309.10394-1-oleksandrn@interfacemasters.com>
 <20250424170818.23970-1-oleksandrn@interfacemasters.com>
In-Reply-To: <20250424170818.23970-1-oleksandrn@interfacemasters.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 4 Jun 2025 21:41:57 +0200
X-Gm-Features: AX0GCFsLYTGQ_5qTGoXIyKWMVzOUDTiw42EgWHLzDMQawuyvQBtogJz92_3pPU4
Message-ID: <CAJFAV8xXamToUHagzmJv+frW1BUGqVjEB5oOOm4v2Hb3Oi5+EA@mail.gmail.com>
Subject: Re: [PATCH v2] trace: fix out of bounds write in __rte_trace_mem_get
To: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
Cc: Jerin Jacob <jerinj@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, 
 Tyler Retzlaff <roretzla@linux.microsoft.com>, dev@dpdk.org, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zEmKTrP1oDJoycgrEIJWErxYYYh3FnPcVpqkNDTZoqE_1749066130
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 24, 2025 at 7:08=E2=80=AFPM Oleksandr Nahnybida
<oleksandrn@interfacemasters.com> wrote:
>
> Offset should be aligned first before checking if there is free space for
> another write.
>
> Bugzilla ID: 1665
> Fixes: 032a7e5499a0 ("trace: implement provider payload")
Cc: stable@dpdk.org

>
> Signed-off-by: Oleksandr Nahnybida <oleksandrn@interfacemasters.com>
> Acked-by: Sunil Kumar Kori <skori@marvell.com>

Applied, thanks.


--=20
David Marchand

