Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3BCC4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 10:07:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FD5A402A7;
	Tue, 21 Jul 2026 12:07:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0DA9840289
 for <dev@dpdk.org>; Tue, 21 Jul 2026 12:07:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784628436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oDI93Rvs/WPi8IrEpjdfEAJblZpeIQqNfewKU0ABN34=;
 b=Kj8dvXTFJKWXwG3Ef4E2+27qZTBsrfb9xAswVEQKRHSu6dImCeTE+JNQOkHg6O2IdzPJkT
 mwU0R8l7t9hGVuWjMCxwLLQ6Xo96TWxAw2qIQVmNqwDjjzuPs8n6/QpjqT2KJAi4X9L3bo
 oqj7BO8ifdSJbFZeGv6loj57KZlPeOU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-eH-Pu9DrMI686Ix1E5ev5w-1; Tue, 21 Jul 2026 06:07:14 -0400
X-MC-Unique: eH-Pu9DrMI686Ix1E5ev5w-1
X-Mimecast-MFC-AGG-ID: eH-Pu9DrMI686Ix1E5ev5w_1784628433
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5b15c8b5450so3600459e87.2
 for <dev@dpdk.org>; Tue, 21 Jul 2026 03:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784628433; x=1785233233;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oDI93Rvs/WPi8IrEpjdfEAJblZpeIQqNfewKU0ABN34=;
 b=f6FdR+EA2RdGRVyEstGY0T4CNerQjUBclasZNUVkp+yFF4nnXo85WJ6pNhArUWTNIv
 8Gko71rMGkTvs4hZwcTK8OR5f0f56bxBfdQcwRD2Jx4DVcGL0QH8D4rjAO7t56FCE/O8
 3J/Xr5JMBHX9Q9FA/n6mdzW5XhG0XCj1r9LKr6fu5ZEZsW8fTbRL+Wx3b+vs/5jH7qhP
 gOfNGJyheiHb3VlEZWNK69Ad2VI+s3M2eJ88aWqESRl31r5nVW+GbesPAFEZh3hUm++5
 ZQx9d5COcMWVPsRxqqSRF5KaCK7CP7XRsa/xzzGX7p9tTPv9Yxegf/38LYwvoeoYOlXj
 dflw==
X-Gm-Message-State: AOJu0YwUXdz7p/jnthDeNRjQYKyGeKQ/W3e37inNgnv1wkNeqEnLzBoZ
 Ntp0Y6ud1VSiAY7kOfgJa1GLONTdTcMErsF1IKDU8jqvnADqnAbxWs6QPPKD7XEoG58s9sdiipB
 FnkmMqGmJL5ebFW3eF8JZ6/7lZRWkY3DKRfCmHfi2M7CglcO6BCF4InpQol/RaDvWGDXpVdiOfc
 M2ZpXmckoy6RlZB+lY/X9zeFrTiIY=
X-Gm-Gg: AR+sD11A++3u/txYuxbdeUyhqp9pThFoTUexDvoac31IQoVQg/PM7d/ENSLnnh6167e
 w1FW9gblHvZJ+WEjNfWWyJdtwj+ggka/lPjV7zbhXkJEPTdtQPmkh1pXEM1yPlsGie0gqtJVpti
 zwMEyEpggNTQcqIZ3D/IMe70e5yZ7FZVIr2Bomh2YxjjlC3nWOYJm0+lUi/HqGfaRRDFJP9yOQ7
 WkXuhAhbdX6UQq4U7+xrZmR+qRjqMW43st6yRXlcIDyeez+
X-Received: by 2002:a05:6512:1156:b0:5b0:ce5:a04f with SMTP id
 2adb3069b0e04-5b28face409mr4669854e87.61.1784628433018; 
 Tue, 21 Jul 2026 03:07:13 -0700 (PDT)
X-Received: by 2002:a05:6512:1156:b0:5b0:ce5:a04f with SMTP id
 2adb3069b0e04-5b28face409mr4669834e87.61.1784628432454; Tue, 21 Jul 2026
 03:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260603023207.31974-1-stephen@networkplumber.org>
In-Reply-To: <20260603023207.31974-1-stephen@networkplumber.org>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 21 Jul 2026 12:07:01 +0200
X-Gm-Features: AUfX_mwCmzCNJfXnZJuRd-AZNgf68XyOroESuME9kEa3qGaASOn6AkOoZiXxXQs
Message-ID: <CAJFAV8zhrp3ke9k_RnwG28x-M8MzhK7R+=BKvc_+piZ+a7VcfQ@mail.gmail.com>
Subject: Re: [PATCH] doc: add deprecation notice about upcoming change to
 ethdev API
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YCVPAMNlZPCvktL6SF0n5JeLPSwc7mc7Eh83q4ufN5Q_1784628433
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

On Wed, 3 Jun 2026 at 04:32, Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Inform users that rte_eth_dev_get_name_by_port() will add a size
> parameter in next release.
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: David Marchand <david.marchand@redhat.com>

-- 
David Marchand

