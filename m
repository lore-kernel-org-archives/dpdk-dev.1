Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28D0CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 09:29:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AED8340272;
	Tue, 13 Oct 2026 11:29:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id DF380400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 11:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791883778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c3M1cQ1mhsRmSPlu444fpWeKtFw9+R0+E59XUWCZ//M=;
 b=hUpaUdsnH+N5AxDgLFI9lY4FRpBIU/pUi5pOrfTCAV3E/r1L8cntMHs5dADKUXEouDyX9s
 HG8PYvbR7IIWpQUIRWz9NFxujs8v2MBsAQZ6da4DC+lgUyMY5/Xwq7qmf1t9z/pRonAC7W
 MOVFe0u+P3kT3f4jkbezhoaeBKsPSNc=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-o9MOwGX0ONKG96Hev-w0jw-1; Tue, 13 Oct 2026 09:29:37 +0000
X-MC-Unique: o9MOwGX0ONKG96Hev-w0jw-1
X-Mimecast-MFC-AGG-ID: o9MOwGX0ONKG96Hev-w0jw_1791883776
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5baf6f208f6so1737876e87.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 02:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883775; x=1792488575;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c3M1cQ1mhsRmSPlu444fpWeKtFw9+R0+E59XUWCZ//M=;
 b=SH56fafmgwZ+5x7HRk0NfmMu+TvVWQAJzNYGqsOfN9VvRe7RRFEEEMYvdfS2kAnK8B
 AzFWXXWa8z/gOSOClOFpZkZ3dJhiTncBtOIDRwIgl/KEX2lfP5LqlGLPDmF7CZ2pCK44
 UeSyez11dKYAtill6dzgTiUeemreSPAj08mxJUIZu7qNjI1u1PYRxQFUilQwyeL3xL23
 cyNa5EBedon0wYCrIGOACtWMXed04+3i/2cQ4UMF2I1g74fpL/wMFW0Bt0IPx0BbgHZI
 beTO3bgWPcyaA0ltg0/NXpd4dOWugCpfi/FPtIGmHXQ6JQCKm9M9d+r2HoBVVkl9L/uX
 W+cQ==
X-Gm-Message-State: AFq9FYJXZmAAQ0VNK6OgNezCyCuME8gNsbIrvNQ24Qn34lxG0vEcEcdb
 pTpNp7CVjSmcnHYBZb00rcfpnsDBenoorCOsstxHxPML/ZsrEubSFVQQ0cNYtKbXlW0qH0Dsrvj
 pgY8rdn20q5KNakCJvHr+7ZJ/iFywKGPUp65KmK8Ge/SRAjw0N0EinG4r88UVVI/zgEwjMVzPgX
 dIIiJQU0PxBSM2pXKVPsI=
X-Gm-Gg: AYBFou0kquldl8pJYVMGqNawvN9W6pn/7IFqQYhPzJwpZX3+X1+EWAGxAl34kdpI/Ws
 S+g+3uYDf0PSN8U89KRUyadPgZJOznP2aOfee1FQ3U5GiL1WVJ4z+Fru8VtCotqXwwciw+Yj61O
 g5fqZAW4maWWdH7bKvGGlIlWh3vYIioEhU/445bKlI0w4SJ5BSiahRljbpofk0j/wT+I6lyJRag
 3O29M3oLY7mwlcS9y8/b1Vby9m9yfWYI9J0MfZERchWm/bI
X-Received: by 2002:a05:6512:3e1a:b0:5b6:184c:7d9b with SMTP id
 2adb3069b0e04-5bcde6d14f5mr4623020e87.36.1791883775450; 
 Tue, 13 Oct 2026 02:29:35 -0700 (PDT)
X-Received: by 2002:a05:6512:3e1a:b0:5b6:184c:7d9b with SMTP id
 2adb3069b0e04-5bcde6d14f5mr4623008e87.36.1791883774996; Tue, 13 Oct 2026
 02:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261009114818.3630839-1-david.marchand@redhat.com>
In-Reply-To: <20261009114818.3630839-1-david.marchand@redhat.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 13 Oct 2026 11:29:21 +0200
X-Gm-Features: AclHuK-xUYA9vAbwLzU1_gV7JPRjq_a8UNWGG-JyxUtd-Pemm-UJIyoyFxYj9zQ
Message-ID: <CAJFAV8y7UoTGRwpO=RFDwM5knQ9hqDaympjj7Puvwp0aEfQU5Q@mail.gmail.com>
Subject: Re: [PATCH] drivers/crypto: remove dead code for NXP driver names
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jVJbVfpM3nw0TeQLG9twRgWVPi20A1AX2CdkgsbCPdY_1791883776
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

On Fri, 9 Oct 2026 at 13:48, David Marchand <david.marchand@redhat.com> wrote:
>
> Both drivers invoke RTE_PMD_REGISTER_DPAA/RTE_PMD_REGISTER_DPAA2 macros
> that overwrites the driver name at registration time.
>
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Applied.


-- 
David Marchand

