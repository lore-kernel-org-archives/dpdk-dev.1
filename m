Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD12CD4F3D
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 15:03:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B2EC40608;
	Wed, 20 May 2026 17:03:19 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id A6E044042F
 for <dev@dpdk.org>; Wed, 20 May 2026 17:03:17 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1309f4ee97fso5613862c88.1
 for <dev@dpdk.org>; Wed, 20 May 2026 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779289397;
 x=1779894197; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kc3/mfCASLrtfWhY8BWP42ulfwmZLEVPb187yPlrUvY=;
 b=e/EUFga7/UVDM56yeFmuf53wvLPvpAZ4RYu3pnw85wITvUPKVLIWxG6hSxHCSVpbq7
 OTgg2aAJU6o5XauVdDICZL+j1+kNjKPWBEeZl9qmcsIaEa95d9Gltqo0F9xoRcWiXCbQ
 poBXffvyjzTw9uRuNcRu6TtGcOjdh4MX8vIq1cKdrDp6iNtKjTFvo/eQF3Ii/oCSwSTd
 0393+O9JsnnnQL5bS6wyWJnTUA+CFqb4GfeBdvpiCSFy6v6Uf3jzeeXeRGeWE4gBIHB3
 nyr80l4fWBhLFR28guWi9gy6yvjE8u4hJI/b0cgeyldzqngu4cgaZ1QG8PohM15TT5gd
 DNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779289397; x=1779894197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kc3/mfCASLrtfWhY8BWP42ulfwmZLEVPb187yPlrUvY=;
 b=XKtc9lS4BJx+3yRlP+BTiKg9IezfIGBjUik+/4ibdOxSzMCkqvIQepnLDNy8AD8ql2
 qO98dlakEjDy5ffX83F/8K81WvqbCFytaLeqaW1EQA9yRAU6QmVzAAU0tmugBEonOqUV
 qYjnGaWuxDcrStmCPT4IH5yLECwQ8Cra0owlvHQrUnHoQgdoi755KdWnagNrxDMbMx74
 6E7rsvA5wfBHmz87NbztYHHB0BNanZAY5s+KADwW761iCaBLQhuSLs/ado0ggriVYBYG
 c2luhJluKxMo6k2NK2AgGRaXdUWb2eVlMq3IWftj6GTQMnA+X9IaRazja6P17lFYLUHo
 S8Hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+k18TCfFsnl5TRZdDnoFmyx4ZQ4za0DLpQnEkglWYcNBTzSmKGpCgSt88JySGPJnmn/Gc=@dpdk.org
X-Gm-Message-State: AOJu0Yw6C1iEa2vbpXJbNmDjfrWY/DmKxS0psdedcUq67JxvzLoqIiN/
 hVxxoQ7lJCHfEFW0lZplSCW+kZaxP9+opmw/LEKedKevXlEjBCka+7jjxDAx21J3SmO0E7M/6oo
 W1wLcEhw=
X-Gm-Gg: Acq92OFamWkpz2nw0r7Ej+LwYmtNXS+EaXazJ6C0pj6sKR847pCVJivZWZILUYJ/TnL
 LK4juWxJJNf1IwAqgcFTrxUY5RqN5FtqdU1BrgJeElMODwJb6CjpY1hHxGEiS2DqBbLoXARfvg2
 8SWDwvFvAaCucPklMNo9Ku+IFJ6SIiS9vTDk2jrnDp/ub3zIIS/dR4y2kjevAf3LtfOcM6HwlxO
 XM1sm/+3OJdpalHAp4WlVqsGafOkD31+mMCxWk9J++foNK988aRuiGIL5AG5H0MVxb6NYAgy4U+
 uWCb7rX8RcU0MQKfKI+uYKmRdvWquem+XqflRIYPYYE3DUcyJcMPzA9nBAIQCm4f7S/MFO6sRih
 1TF+gIyed6e4M/OVv46/SGelr6tm74KhQ6g4E23T03PnBqTLB16kAljSOyZmWLr1EPaKN7BK5Tn
 aR+1FFzW8QcsVJNDfXr1T0SWgH0TDy3bjZ6sslZeVQUMEe0HxwbvLUsS5RaGlRr7MQ
X-Received: by 2002:a05:7022:2586:b0:12c:856:ddcc with SMTP id
 a92af1059eb24-1350474133dmr11187895c88.27.1779289396536; 
 Wed, 20 May 2026 08:03:16 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc2351c3sm29094702c88.11.2026.05.20.08.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 08:03:14 -0700 (PDT)
Date: Wed, 20 May 2026 08:03:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: <thomas@monjalon.net>, <dev@dpdk.org>
Subject: Re: [PATCH 1/2] dmadev: include device name in telemetry list output
Message-ID: <20260520080311.29609948@phoenix.local>
In-Reply-To: <20260520035641.50555-2-fengchengwen@huawei.com>
References: <20260520035641.50555-1-fengchengwen@huawei.com>
 <20260520035641.50555-2-fengchengwen@huawei.com>
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

On Wed, 20 May 2026 11:56:40 +0800
Chengwen Feng <fengchengwen@huawei.com> wrote:

> After this commit:
>   {
>     "/dmadev/list": [
>       "0    hisi_sec2-0-dma0",
>       "1    hisi_sec2-0-dma1"
>     ]
>   }

That is awkward JSON. Better to not have the 0 and 1 prefixes.
Typical usage will read JSON in python and array index would
be implicit.
