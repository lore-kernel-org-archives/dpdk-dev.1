Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C7D1950F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:16:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C35EC402BA;
	Mon, 26 Jan 2026 19:16:36 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 5596D40276
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:16:36 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so4240039f8f.3
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769451396;
 x=1770056196; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+SxVYWOyMEqgckQHP45r7z/hXHsoyHYLWNEuHo6rgVw=;
 b=X1f74H54+kpBHaO0iOypEOM9HVyOPpqtAFRpExq0Ozp/gvINYcC47I31bbVtEK3BYL
 b9+7ojgVZagUtUYH5inDDZSaO8pLTPysnmG66EUQdDanQ6RDxwP926h+Se09fDwoZFW8
 BIsaPOGLOTuNiYmt75Gy+U28DABZVFDsjMzjr0/23emMkVCRhrjG0Z9Ym2VDbpCTUzqk
 AxMMd2/iHh58TiTDFsoKewC6XXilywqYL4WhvzdSD+xBFFJa2PEsyVD+SYgJvWk4elft
 s2gw4jgRWKY9DDOTVHsXcbiE/tlUTOmQAwiowmOwoSVESgpC7oSupdv3hH/IfOBiHF5f
 XztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769451396; x=1770056196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+SxVYWOyMEqgckQHP45r7z/hXHsoyHYLWNEuHo6rgVw=;
 b=w6Lk1Tn3lH6kPN5PpEHYKS7el/MqxYL9MZDZ83eOyU58KWm8WM/WDE3Ol6GfIrRYNP
 OQxKxI0tWmsmLVmFzplPBEHC5s9EtA1vj6j3zqNVwPll7Z6mHt4Y+gwsg+/31VK1vI17
 iWXS5NdHtQ4fwGhq0mQsz0N/IHM58OyVuWoapXezIZ2SA6gPm6j6sfCPRs4AdTNubs6J
 yuF2AgOtpiKXFaXBFEcOnXEf0BGmrnr5ljRp5Sdjl9B48t/3cGpuOjVpyV6v1KIeB4Hv
 aR5bxrwHJL0OVur7RAAn5Mo/hsu2nXqRoxnEKbwG6U6E7JsTf920Q+yFnr8AP//PW29+
 gUtw==
X-Gm-Message-State: AOJu0YyU5WUWStsOnPTwEQObfo3dK++4o2DQ3TSBewcRiWFGqmRXbTPl
 C96IF6OZa8s9lH1SldodOtwhTAEgILXicWBtBL1xpTxZLSGT9/aMjCR+6sqTnT5XBqUHzUETVal
 knpcX
X-Gm-Gg: AZuq6aJSC7vYAjZpXiTSOhph5X2+ARyHbkD3iWNal9GueebvJ+lL6cbwlZW9OaT/35a
 RbrR1WwBuxZk7CB5kHCA0brWq8nj6YJoTos7pdp48XVeyYaewj7FALZJYYeU9uiKiO+P0qdRoWW
 dUjm8LUKlXsHB36+FDOohPwDWNIxbUWYp/dAPhBDuo1IsV6clOzNv68tatnXOmEVrDPmS+ppBpW
 qDXRshlTpdzYcdTKELyry3JuilXAq+SLVQBHa2+BWLi+/iRUnrQe/WMi0iAJVA6hmiuEwR9mkck
 M0glN+yaZT1Y9tOnirQY5mS44CNaM16rtHG89bYkdY+mZtYolVOPZfLw8Sm8M/n0NetWBYddyNg
 3u9tLFeOKYYSEQ8i25j9xU9CUKADlR+k+1g10QW9d3WXqWFuFG5UsG8xbuG/ymTi7BO59kIT71S
 JTw4FY2gu4iotVQKqxj7y7Gr4lf6VqnU22WfC9FG5HXXIO5EgEtAU5
X-Received: by 2002:a05:6000:40da:b0:432:dc23:368 with SMTP id
 ffacd0b85a97d-435ca139180mr8601899f8f.49.1769451395832; 
 Mon, 26 Jan 2026 10:16:35 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm35456939f8f.25.2026.01.26.10.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:16:35 -0800 (PST)
Date: Mon, 26 Jan 2026 10:16:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 1/2] eal: add location info to interrupt error message
Message-ID: <20260126101631.144de68e@phoenix.local>
In-Reply-To: <20260126164519.3029952-1-bruce.richardson@intel.com>
References: <20260126164519.3029952-1-bruce.richardson@intel.com>
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

On Mon, 26 Jan 2026 16:45:18 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The error message about the interrupt being unallocated is called from
> multiple positions, so if seen in the logs the user cannot tell which
> function is actually generating the message. Add function name and line
> number info to the message to clarify things.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/eal/common/eal_common_interrupts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
> index b42fa862f3..a2a310750a 100644
> --- a/lib/eal/common/eal_common_interrupts.c
> +++ b/lib/eal/common/eal_common_interrupts.c
> @@ -17,7 +17,7 @@
>  /* Macros to check for valid interrupt handle */
>  #define CHECK_VALID_INTR_HANDLE(intr_handle) do { \
>  	if (intr_handle == NULL) { \
> -		EAL_LOG(DEBUG, "Interrupt instance unallocated"); \
> +		EAL_LOG(DEBUG, "%s, ln %d: Interrupt instance unallocated", __func__, __LINE__); \

Using "ln %d" seems different from other places. Maybe
		EAL_LOG(DEBUG, "%s:%d Interrupt instance unallocated", __FILE__, __LINE__); \
