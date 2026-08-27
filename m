Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29783C61DC7
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 09:08:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02FCA40150;
	Thu, 27 Aug 2026 11:08:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 006CD40150
 for <dev@dpdk.org>; Thu, 27 Aug 2026 11:08:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787821685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N87lIJrJnoGNIzXaLr/y9KgR5ykkQ4LUtjy0O6FLGOM=;
 b=iFc8aAF+oJgolNhZ9nk6ffcv2udSpmcHLWRMwIMpHa3DWQ5gPe7oeHNAG1eetMiTSboC4U
 Q03UiCfDKOtXxvaP9wbE7/G3rE7CqWMOo4GdB1bBn5jVR8KKv4eaz8pPepGSsBdd3ouBTM
 ON33EB2dGyIIdmWTglIzShDgB5C96yk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-AEQCnzKwPreE11SeizLwfg-1; Thu, 27 Aug 2026 05:08:04 -0400
X-MC-Unique: AEQCnzKwPreE11SeizLwfg-1
X-Mimecast-MFC-AGG-ID: AEQCnzKwPreE11SeizLwfg_1787821683
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b4a389fce3so1125723e87.0
 for <dev@dpdk.org>; Thu, 27 Aug 2026 02:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821682; x=1788426482;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N87lIJrJnoGNIzXaLr/y9KgR5ykkQ4LUtjy0O6FLGOM=;
 b=EdXd7g+ILXmxQeVygM/PrG4LtSWLJ9b4Zhl7RQFUmZNwR/Ip0q0EzwmenjBieYEtFq
 KXMX4dLQZ1iB2Sf+zvL1MZbLst3Sqoz2h3xIyUTEPPOFDLjpg7xxwvo7PVKNSJmZsmdq
 U3PXFE4KNYpkk30jJMM/dzujhGSIYYRb4SM6hS18c2RSK3hQqgJLcQSRSPlZ6CMbHTv4
 QQF6sPyrrTu+dU44JjjzA1+JBhmyuap5s3LCU82TiRqmMcShVlS3R6OdUxKyI3vxVodm
 N9kOZumn7/g1kZTTr+UtQ1ZChlVQ7wDn+Ugr4zmw8F6n0fb9bjifxV9JkyKKA8ANVtCi
 usmw==
X-Gm-Message-State: AFuF++mhIi5kFhuAZUquSq4V+hJib0e8Jvloe0WlFL4/0nnqo8QDapxj
 Gx0qlmgOwq1rk/xvfZ+mOZ3eMdUZfZ5gWXdubP1iJPgxnKrdHchaLB13TB/6YJP/1XL3KH3ASuN
 nN7I6AZEN1TfBGekqZRCeVbiNXlQZbzDiYiIPvlxqjXyHYn1ZcfknpxB8jLnEKQjdgeSPS4Ahfk
 +X/JOSMJwkfjsxPa2GAbE=
X-Gm-Gg: AR+sD12wRwJ5ths5/ZT7MpVieMChqINQVuJ10AbDbTdXpsGhI4LwakqbgmP3KYWaWee
 aJ9U1iv2bCv7H0QFPORrIcVelFiRQFAAxqAsAs4I5/1gqoz3yg1Cc2IJcvh5eIEFs+EEKm1jo7e
 cTm2FFplB/dJm3HqKpnceJDz66cbU85o+ObxiykfsXSI8/VL/JUtdZHOzfHBRYVffM3AMXldk2/
 Xb8+G36j3ObWIpF90/iNpl82o459qBYlkXVZF8DQjKr1QiH
X-Received: by 2002:a05:6512:1192:b0:5ae:ba8f:f9fa with SMTP id
 2adb3069b0e04-5b4a909e2c3mr3618414e87.18.1787821682463; 
 Thu, 27 Aug 2026 02:08:02 -0700 (PDT)
X-Received: by 2002:a05:6512:1192:b0:5ae:ba8f:f9fa with SMTP id
 2adb3069b0e04-5b4a909e2c3mr3618395e87.18.1787821682015; Thu, 27 Aug 2026
 02:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260826235933.194681-1-stephen@networkplumber.org>
 <20260826235933.194681-2-stephen@networkplumber.org>
In-Reply-To: <20260826235933.194681-2-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Thu, 27 Aug 2026 11:07:50 +0200
X-Gm-Features: AcwNN1UCqvNdoFpiwkUmsEADPS4tFe_vF75KvLZnaBeq8IpO9vR0FLW_wCDsIek
Message-ID: <CAJFAV8x62b_zeyF5P-X4KSMxaD4Sd=XanED-7PitDztxtnUFFw@mail.gmail.com>
Subject: Re: [PATCH 1/4] common/dpaax: fix unused variable warning in
 non-debug build
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org, stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>, 
 Sachin Saxena <sachin.saxena@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eENlT1Ba7hawzXjSX3Q2n1WrwEZbnaHlzPZp3zirXhU_1787821683
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

On Thu, 27 Aug 2026 at 02:00, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Fix compiler warning on clang-23.
>
>   dpaa_of.c:14:12: warning: variable 'alive' set but not used
>         [-Wunused-but-set-global]
>
> The 'alive' flag is only read by DPAAX_HWWARN, which expands to an empty
> statement and discards its condition unless RTE_LIBRTE_DPAAX_DEBUG is
> defined. Make the empty expansion consume its argument so the condition
> is still checked in a non-debug build.
>
> Fixes: 8c83f28cc8a4 ("common/dpaax: move OF library from DPAA bus")

Not that important, the issue probably predates this commit.
And looking at this change, it seems DPAA_BUS_HWWARN is dead code since then.


> Cc: stable@dpdk.org
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Otherwise lgtm.



-- 
David Marchand

