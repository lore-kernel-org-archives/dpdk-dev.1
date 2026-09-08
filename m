Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD02C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 12:31:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE68740374;
	Tue,  8 Sep 2026 14:31:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5DEF9402F0
 for <dev@dpdk.org>; Tue,  8 Sep 2026 14:31:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788870681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RAsa+ozahYfHIMP44ySNxOdFUZq7bWHqBVhL5IClI/c=;
 b=ET5hE58b79TC8cetpXVCdBPkstUrcIEXEp0nH7hCiSuaR+Bm5zK9oH+BxL/GWu08iqL0Fi
 5LXIQjRAcq6xg37quX7NQ1Ljs2VAcY+98Scl4fEXdMbjbdcEEBp1+q6q/o1J1EaCpW9NyS
 g7k5TZJoZO2JjNhOEdt+FeI85Jp249A=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20--PCdu09uM-2aHy3VsiKsXQ-1; Tue, 08 Sep 2026 08:31:20 -0400
X-MC-Unique: -PCdu09uM-2aHy3VsiKsXQ-1
X-Mimecast-MFC-AGG-ID: -PCdu09uM-2aHy3VsiKsXQ_1788870680
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-980c5766c74so85477241.3
 for <dev@dpdk.org>; Tue, 08 Sep 2026 05:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788870680; x=1789475480;
 h=content-type:mime-version:user-agent:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RAsa+ozahYfHIMP44ySNxOdFUZq7bWHqBVhL5IClI/c=;
 b=RwFy/Q+v93vpHSO1m+If23FHp3coPghFIoV488Mv1UDw0Df9Zl0LndjFn+mh0PnZAY
 KXFXxeMSqcNIU43uOV5VZUZJNdjSyqVCJISTle1W38Q0lmldWNUgZGNqBcZYKXui9BF3
 pB0m8erp85hr0rx4SWcM3kcriwK0kEEW07qgKgCDwaU74zTNgemtts46p7tfsmuFIAy4
 rug7MVr4yQzVFVMS3zHjRfAtgsoEsuGnGzQczlMEO8gQlLBCccOjAqLGmSjEb7XquIag
 cJ2O/U/XAqtRsLWyixSmV2XkiKYHyTaoJcHRXQr3ieHBJGl+VO/Strlsf7d/p5j7gB02
 YveQ==
X-Gm-Message-State: AFuF++l6SwC7ix6iOkGG9orq3LhQ0sMx61neHN5euBRn7aHPRIT9FNEk
 2WyngFIm4OwrxVDchIpW7hpFuqkyae92y44Ggad3n0gML3FZkCUFIrJD3uzoRYBpnect9Jk5Dnr
 Z3NiWwiJdv9LikYaAQoFQaKmOEtrVqZewAjVIbzR4t4WRdQuH4B7ie2XfAhDJeRupWiQAXzS9NG
 6HiUypzvxifVcJTIdFxHbRMUQ0z/Y=
X-Gm-Gg: AYBFou3/WvIjeJwoOk3kk5JnTYPyhDa+FHYhu125xWR6+BpG9VyEbU3O99ywlg74opc
 ToWmCoXRFVxMKBFyJf6fYpwG5mul7v/qNKjwWrI/+ISsuBiIyCbMuT84ZZPq/UfDRmJFb8fnHiO
 L/y4ZhebNEPIC+A7SjHPtCEZfIwti+lDhEN19DfCmSxaavl6Yb9uCyvoNgoAcc/69tUUEvpFqH4
 in5gDn1XxNEUwmv5mROChY7A9yH1W59VRBVtk9a1Eex60ETVcVlubMOPtjHzMjzIP9bvARYKkW2
 UGth2p4hcPJtXSMiuEtfEYv8KdW92BfJMETYXIZdE9Js+uR8kDR2E7sNBntUrWuIS2NgTy8I99w
 nIPuUmxGsS96LUTVPl8yNOv368v4P
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id
 ada2fe7eead31-78a4a7186d7mr9955798137.7.1788870679412; 
 Tue, 08 Sep 2026 05:31:19 -0700 (PDT)
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id
 ada2fe7eead31-78a4a7186d7mr9955763137.7.1788870678734; 
 Tue, 08 Sep 2026 05:31:18 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([216.212.25.12])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939ad19dc90sm459038385a.41.2026.09.08.05.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 05:31:18 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 2/2] devtools/ai/review-patch: reduce spurious warnings
In-Reply-To: <20260904162454.218213-3-stephen@networkplumber.org> (Stephen
 Hemminger's message of "Fri, 4 Sep 2026 09:23:08 -0700")
References: <20260829171822.305500-1-stephen@networkplumber.org>
 <20260904162454.218213-1-stephen@networkplumber.org>
 <20260904162454.218213-3-stephen@networkplumber.org>
Date: Tue, 08 Sep 2026 08:31:17 -0400
Message-ID: <f7to6e7j562.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QncijwFC6ujSAJGjgsuyaopm37afc10slaqH5uQlnwo_1788870680
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Stephen Hemminger <stephen@networkplumber.org> writes:

> Improve the logic for reporting warnings and errors to
> avoid flagging good patches as suspicious.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

