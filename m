Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B973EC369D1
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 03:40:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E52D4400D7;
	Fri, 25 Apr 2025 05:40:38 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id DE099400D5
 for <dev@dpdk.org>; Fri, 25 Apr 2025 05:40:37 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso1906412a91.3
 for <dev@dpdk.org>; Thu, 24 Apr 2025 20:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745552437; x=1746157237; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cOr9S4OyUO9dwNkP/9X5ZrnAPoFHQ1/ZdZVnTuQ4BMw=;
 b=Dm/ovEkqbSXC9Yk8KmXS84MlCm8MNMS6G0AVH8ka9T57uNi0wzQ1361SFOYpg9BLbt
 oiUTPDB9MPQsTo/vflbAiqvJpDwRsOgt7VUmX3BNpyhe56OzEztqCtKsgD1q0VutQqg8
 uJ9YdHTS0Bu+8bM8RBMu/30XSjFRD6BqIlYCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745552437; x=1746157237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cOr9S4OyUO9dwNkP/9X5ZrnAPoFHQ1/ZdZVnTuQ4BMw=;
 b=v2M7IWtN+uosM9uuz9vPlcUSvCVyUzBs6xAYsRLMi5Sa6YgahkItf82ESZurXjs0+i
 SIS+q0l7YsZn7TsH/fB7sscdJUDxXHS7eOYikgw9Y0eUnuTXSvuJZ4RWWI6+5V6yCVTa
 /avYpFiC1WLXhnuTve4wIqczHLZWYEQynQE9w0QPYPC8Jh6L+RFOlcjb8MMtqx1oWJvL
 lGF83xv3zbEtxf5PbL+IwU6IKHfKxYy63Nlr9ZMQwGQNJcqckAK+glThij3xBDmhwWoX
 fEyYybzr8/O0drkc2/a7C0i0QQ/tNmXkQv+adW8ToNonqtZZg1zgHycXCPE2Jo+yPik9
 DPXw==
X-Gm-Message-State: AOJu0Yw/LEpqWEbPvp15NHzEDFZsl/1k6J55ho6vAxN2ImeF392HGwNO
 TFVUDq4E42I6107bAHg2/gHZb4vI/vKdhv2Ktiy9PLuYt5q/DHgjRJctFMzBMXZY2lkUV5L6VDS
 SJ1JPCwgbMcbZ2E2GdH3Bq7gb3yUugkXbWqLHCnY3FV1gu1EB
X-Gm-Gg: ASbGncu0jhf7cfBTSd2Ch6I4tyWy3DhuqFngjAh8kVcyUbNKgHXKE15oXwZWZh2DIrC
 bjfN/bb3fI41bt8ER9ToBMoXs5MSMpuvXrTqie/qGVEPrA5A7VZPppL5CRVhISedSwsb1L8DIPe
 Ud5r5TWENO7YegHvafpw8bblGXCxrJkFkijgybbw==
X-Google-Smtp-Source: AGHT+IHyPvxoTSll85ez/gPsTbOqeQiPmC8FcWuKJk62x1BJLLGcZaaHzub9T+4V0xrJgTlwu3zJveNG1rRQK5j8lIM=
X-Received: by 2002:a17:90b:5241:b0:309:cf0b:cb37 with SMTP id
 98e67ed59e1d1-309f7d99270mr1705246a91.7.1745552437094; Thu, 24 Apr 2025
 20:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241220172337.2194523-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-1-luca.vizzarro@arm.com>
 <20250314131857.1298247-7-luca.vizzarro@arm.com>
In-Reply-To: <20250314131857.1298247-7-luca.vizzarro@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 24 Apr 2025 23:36:13 -0400
X-Gm-Features: ATxdqUES9yOd4fy_fAkOay47MdPtcvNB-Zv_OiNrTQTZjUP2Vg8EqzPiSUzdtg0
Message-ID: <CAJvnSUCDVgKa=GiroYjhXbnE2Tcrk1Tw+VM8Q0kdMGzOuiM1uQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] dts: remove multi-inheritance classes
To: Luca Vizzarro <luca.vizzarro@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>
Content-Type: multipart/alternative; boundary="000000000000f33fc60633921853"
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

--000000000000f33fc60633921853
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000f33fc60633921853
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Reviewed-by: Patrick Robb &lt;<a href="mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;</div>

--000000000000f33fc60633921853--
