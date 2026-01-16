Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3CC982E0
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 17:39:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A83F042E7C;
	Fri, 16 Jan 2026 18:39:32 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id ED0534026A
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:39:31 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4327555464cso1266661f8f.1
 for <dev@dpdk.org>; Fri, 16 Jan 2026 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768585171;
 x=1769189971; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yTFuh3z/rFM+OxJ8AuhPpReFO1U2YSNQg5lscrJOo0=;
 b=xbCKbmU3Z91t1UD4FdRbW/LRWDYJGNqprAWd46O8SJ58lkfJ55TZ8SCLYmzHq6S6nt
 r0hF/A/kwZ4/9XEKMHnEWyJ55AqO9bUo4VP2XMpUFE/WOYe94P2UYJGvlpEG8RISKyP7
 P4JSGkESd9npEUxmPHKZa1J4C6TseGJcBl31l68/XjfYEnRhTVrNNh9dmuP5LNdjFttn
 8h2fHo9xMAVpKbvD1apHqdei491WkSO+LWo3pgsV9dx2TOFbPqHxe5joLETxNgNJ3C3n
 DrLFj0ZSz72hXrn4xXdEqaChqBZjPxrKTBNs9U/h7IyOgm91xgzLEMkoSTw3rXPauFZQ
 Cojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768585171; x=1769189971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2yTFuh3z/rFM+OxJ8AuhPpReFO1U2YSNQg5lscrJOo0=;
 b=LxyI0QiUU+kSTpTKxb02TsiCeKO4wFp/rGvAsBKBryJsYX+0A2QpCFVNp6OpnS8BvB
 kxB0ejX30oBkWUXR1uMW0qDsLh2HIBBhOtkhFJ8FsHK0N1tsEWkOIRFHWTwXB0Nl0x/U
 6N9hGwXGI73VR+ZhWGNKrpXNHhM3OLaJ9XkE4NZiOU7HIU3p3kCGmaOB93TfjKsBVlAt
 nhNdJkihjaUjhrvXIqK1mldBJRVRmjM4MnrCBBoi6t/4l2l/fSswdriBDF5q2HDShyjd
 zCtIUkBYY+oveD/rv55/xM8hQfEFpNRNHh++8yRtRP6XCzJUkZq73cjiULEoHcatwBoi
 y4PA==
X-Gm-Message-State: AOJu0YySc3/8hyPDTgsK7KbRsc1f9TMmGWCJwlmyd/6v8XQUduZ5WJeI
 hceG0EnkV511vQg3Ypav4Lbpt5iaicBpXpmw+NbuebdAyn1DvidhSEOg3dUus0qEusE=
X-Gm-Gg: AY/fxX55uwxS25+9viBAHrocXVVypVy2WkQwilaEnkiYZ1Sm9RYSDgjJ87DQc1P4+AC
 VZxQRSW68xUJ5M5/H5gTHKN6/07GdnFbYRHXHWf6q6xa7axCSlkGHmKr/6h4BRMT9Zpj1+hSt32
 QxgM6k8nNXkGbimcPgI5NkPEtUlf1aVZq2FsIJdjFF7swYpMsOnX4Pjhp/8BFDp5O4QYDwCIP/+
 OhHSQyg3jYJ9YCjq/5MgexOt+CpDqHuoErVoDDNGk7Tqy2lNypNKzTRw0cqsPievafzd+EQrfHG
 lHGSbR01cahoUrYDw52W8DjZX7KBxZH+/cLzQATqQPL34Bu2Q68SJrT1+HBEplXvgub7nrMIho/
 5tNGKmEfKqS7cRa5Tnm6MIkucKUJSX6myzDppT01xzfVBDKY5PezZQunl+6LWp8INbY0YFeQG6U
 rGIlzQSqLCZ1Y0uSVXoQqttWXX2vd/fKU9ZRWWng/3lCjtod9z3XMSbACic+7+uSc=
X-Received: by 2002:a5d:64c5:0:b0:430:f463:b6bb with SMTP id
 ffacd0b85a97d-4356998acf7mr4354906f8f.16.1768585171470; 
 Fri, 16 Jan 2026 09:39:31 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997e664sm5757502f8f.30.2026.01.16.09.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 09:39:31 -0800 (PST)
Date: Fri, 16 Jan 2026 09:39:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Martin Spinler <spinler@cesnet.cz>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 0/6] net/nfb: code cleanup
Message-ID: <20260116093925.6e397c33@phoenix.local>
In-Reply-To: <03920b87aa9203f2e9eae239e2fd1a9811f6bfdd.camel@cesnet.cz>
References: <20260115140134.235877-1-spinler@cesnet.cz>
 <20260115144040.345873-1-spinler@cesnet.cz>
 <20260115214849.623db82c@phoenix.local>
 <03920b87aa9203f2e9eae239e2fd1a9811f6bfdd.camel@cesnet.cz>
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

On Fri, 16 Jan 2026 10:42:20 +0100
Martin Spinler <spinler@cesnet.cz> wrote:

> Hi Stephen!
> 
> Thanks for quick review, my reaction to issues:
> 
> 1/6: The log message at line 543: fixed
> 2/6: Still missing NULL pointer checks: misleading,
>      dev->data->nb_rx_queues ensures the queue[i] was inited
> 4/6: uint16_t: applied, Doxygen comment: fixed
> 5/6: extra blank line: fixed
> Those fixes will be in v3.
> 
> 3,4,5,6/6: I think don't want to add Cc to stable, if you agree?
> 
> 
> Besides that series and 'net-nfb/rework to real multiport', I have
> another 3 series of a similar size that depends on those series: Native
> Queues, Metadata+Offloads, and Ethernet. To make the work easier, would
> you prefer to have it in one 19-commit series or should I to continue
> in 3 small series?
> 
> Thanks! Martin

Only cc stable if the driver was released in a stable version and
it is something that could be triggerable by bad input
