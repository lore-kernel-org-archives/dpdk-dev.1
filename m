Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90344EF584C
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 19:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54C41402BE;
	Sat, 14 Feb 2026 20:09:06 +0100 (CET)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41]) by mails.dpdk.org (Postfix) with ESMTP id 4601D40151
 for <dev@dpdk.org>; Sat, 14 Feb 2026 20:09:04 +0100 (CET)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so1429069f8f.2
 for <dev@dpdk.org>; Sat, 14 Feb 2026 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771096144;
 x=1771700944; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtpV2Tb53pMOEL8/KAnNXXrqPdmxRuOs0pj6Yg46pVE=;
 b=Gg8Hya5/mVBKkSQGRONOsf4Ba+TLuIEVcGrdHl7HBcPTZksA7C7JOEVxjKNUt2oRE1
 5ypfHoeYWAyYdO1YCxSjqOXkUG4Pim4DXtN9aQ1kN2eU95qX/WZd3q8g6CFf7eZjIwIY
 NXUWdKthwFffguE4VS9+W8u8vv0GwtgA/29M26zWeOO/GHrtzYc8ngv/W7kJc0siUW0w
 UOijopReQWFJQTlPXYCO5mWQIGhy263jumssw8TMVMilgDr+BrNqZLxPaQNOzha8dF/V
 MQPGgxgjahrmxHjhLuQRp1iTZmr2ucEyN/iKIEQfWIAtdS4D7j7btQELZWj/u3b2mB51
 57Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771096144; x=1771700944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xtpV2Tb53pMOEL8/KAnNXXrqPdmxRuOs0pj6Yg46pVE=;
 b=vdFTmQMdQ7N3cppmlsRwEfDiy4BSLLTkQ5EGaO5UfzwmLWOXafwCc7ZQ4sIkvRYXnD
 ZZRqJdiyAzI/msjE6WgoogHr1TAuRYTv0aFESKobKEThFM+TEAmIw33/LAyCBrk9AzWk
 Ps+mi8945nol1ObVckcLj5FdDxeRCVnKxHrXv3oxgPwxFu70C1ZUr/ygJIjc3cgZUrjA
 srqwDJQ7iZvMGj2tkACm+Y2OmKyUMjiSAnuRHFQjTZ2KW3VPq9sg78F+XVhVj7dDRrZ0
 3dc7ieXff4LFv/QpPI2W0HJut4dvUR6L1uGrx5P7e9K9vWOspV4m+Rk5oxkjuyCxgVcu
 XI9Q==
X-Gm-Message-State: AOJu0YwWvwTSYUfHpbCMCDOV21EmXX9HdVBF1qP3jbXtJWPCABToarn+
 rOCqizIDIB2iQmwy5KQ6Ld8L0O2dyicEWPOKukgSx60Nt43D1lKQyUSBu0TGu9d/x4ts9Ckgu3O
 s8Ylm
X-Gm-Gg: AZuq6aLtre561TSvKAU/qqQUXGrbL0w0i06QUoxlR0RUCa0hjLnz53LnpMc5IBmVohU
 i0E63yhf56SWKCOd8XhwOjAuG/HwyLs6Ad+Y/JsWimhM1Y+TFAEwtWZmTDYAoKEpTdrovwOjLGq
 m/fr50E09foRVrVgOBMnK0d8ZRAITqCCPXOOezsxZgd0J+CjY/stDko8eCi7CmKpxKW+48wfbT1
 8Q67bLWi+h6Pgq6LrnwfYsH6bfvC8zinpAtq3FxRdkzUpG2SfQjWV2h1kn78ukUgXdmXWkK1tGz
 Y7Z0s2yo4nBOvBGDyFezKfjrykAfXAPBqgBxARch4EMAtXhdsOaaXlT0/YN8Wz65x1PUCSZTdPL
 7lrNeTDOGlYtxEehQ01cy7BfL2+1GhILq9dpEuRbdWbANHQvDGDFuDVgBxwuQma9S9AV3etf24K
 h1r+hF07O2R6RIuEKQUfXoDWRVQ87bNArnk8Oe9z6/nIFv32QWRsBQyHJU9PLbOBJp
X-Received: by 2002:a05:600c:474e:b0:480:4be7:4f53 with SMTP id
 5b1f17b1804b1-48371095fa6mr128193335e9.31.1771096143516; 
 Sat, 14 Feb 2026 11:09:03 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483719b8e71sm137171715e9.2.2026.02.14.11.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 11:09:03 -0800 (PST)
Date: Sat, 14 Feb 2026 11:08:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kerem Aksu <kerem.aksu@i2i-systems.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3] cmdline: update clear screen behavior
Message-ID: <20260214110858.414afde1@phoenix.local>
In-Reply-To: <20260116154256.206571-1-kerem.aksu@i2i-systems.com>
References: <20260105113529.65969-1-kerem.aksu@i2i-systems.com>
 <20260116154256.206571-1-kerem.aksu@i2i-systems.com>
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

On Fri, 16 Jan 2026 18:42:56 +0300
Kerem Aksu <kerem.aksu@i2i-systems.com> wrote:

> Control+L should clear screen and redisplay prompt at the top
> line. DPDK rdline library will not change anything on the screen when
> fed with Control+L.  When prompt is lost after too many text written
> to the terminal, users will press Control+L to clear screen and put
> the prompt to the top line. This is expected behavior in bash(1) or
> applications that are using readline(3). Updated to behave as users
> expected.
> 
> Signed-off-by: Kerem Aksu <kerem.aksu@i2i-systems.com>
> ---

Ended getting rid of the clear_screen flag.
If there are only to callers, it is better to have each caller
do the steps they want, then call reprint
