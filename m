Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D97BFD45F1
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 21:08:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8A0140279;
	Wed, 25 Feb 2026 22:08:49 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id D999B400D6
 for <dev@dpdk.org>; Wed, 25 Feb 2026 22:08:48 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12758ce1e8dso308894c88.0
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772053728; cv=none;
 d=google.com; s=arc-20240605;
 b=YdWpDxPHQY4S48zcW0MNGWFEMZimQgxnf2G1MmESOGPYvQSTqGlC1U8s04hi51Gdvd
 U3zwu4Kwwyx82rcUbkQU8pxKsy+yKGEvFDHyidRrECB+6/0GnZF+EApgQVd9gwqAzk+t
 FH6pm9IwCyGGwcyfyxbYL+6o8IedhqdMEjO+7QKTFfo7bPQ5uwJdIwofDgTN+80Xsgst
 xmvtj9NMFDyc6TK7WMTnHPxfAIK3gR5/H9tB1qBrrUrz8CrasgXA+Aek7K2yJ3fbVIUb
 u3v9SkY01ILi2luxfxtgczn6Az9DpuAMTGphbF7MI5kyiOL6Nu+3NYvMFZOAbpDn1lp5
 ZTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vX96FEW9lUzeuXBjl7AxP+OHyNtlJqq0CB7fBjSzqlo=;
 fh=egguu3lfJ689NQgA+0vRavT16y1lKyIQVq9LVL+uUeU=;
 b=kJoEO1AapcShmWpN1rUAoXO2SWvWBXo8BX7IuJIr7dTWlItFHQ9/cZMXBiJdIkQ5gF
 KBefSLknCjnouvWkEzBVGrzxlBRXTYK7px/tOPDCCpwPHYpUtIM4eI5phNlPHq5OhQMw
 daR8FzwLpDt6FdGoMt/0s2H0Yur7zVXIIqoOd9O1oIpnd0eWqbx9DGHVlg7NHT0Ck/EX
 m4hiR0sxxczBmQYK9AFz+QSGCOzYfFnNYInnu5+Z8T+4Piuw0fmJ9LEn1R9kH0JKUGm/
 W1KTa1DT7tHkCHj24eetptx6s6GPkGy2TfPMMR9ZMJWgRzuONUtA8YaDyyXMj8V8ojPZ
 Qcdw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1772053728; x=1772658528; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vX96FEW9lUzeuXBjl7AxP+OHyNtlJqq0CB7fBjSzqlo=;
 b=S+7kILmnqqsVU8w9ov58jKIn5xl2jmd1iMLsjK/QPXhWm6jMU6BqNcBMlUtoI3R9YQ
 hNc2AkWUwmGyMvcGtD1k/gu9J4bFksicm8VJq6NGiZn4RCUHpjeLKqnFvCovpMo5+OBQ
 M/CUUr70tS2e6mVQb6f1I7WuF0KGhZvke6J94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772053728; x=1772658528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vX96FEW9lUzeuXBjl7AxP+OHyNtlJqq0CB7fBjSzqlo=;
 b=SoVanc5SKLoRJWbVZhYpK60/9OQNAc2qqW+A0TYKAPeQulBZGwhxwiVDgie8ojP8an
 ARwncCNdCCFzPz9mEtF+PRAaNRNSmBTwU/KhKrI3A8MTNgdPKyOS0BLgpOyi27QoYRI4
 WAxo4BS6kTaL8qqYk8IlhwS0HzgyVT4sXfiFOP+kkvb3GjmrL8L3o+7vAyLSDdh4xns0
 v+sbPa6pQSBnMgrtviAylfmvfLHJPEhqVZeq9rQcwLdfC/neM0p+R4WYq5RvpC5jAa6K
 z3GLFY4RsQraw++e5B8wV9DTz0Ua7CS6IWBW1trL/5e1pvqxTTHYAVXYQ9PZwOvPw3vc
 Goig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzzhRMJUPN8qSF8yx9MjsKgsNsly3IHaAeo06lBFy5UY8ZHv7FwcMBQUHnwEMlFPZPGlk=@dpdk.org
X-Gm-Message-State: AOJu0YyIi8ENXpGuizIo2iS8zDT8tu6jGTFuvIcTyCCCKNBaDLhugdMb
 v5Np0lO4CayWO9AfzqPHs9uAnigQGvUSKE+1/NYh06VDnfu5T2cRCujP7E525dh5ZCmjQG3y9vX
 epGmKZSnvQvz0MCjaPghCB176Kyhkric85AjJ1Deedw==
X-Gm-Gg: ATEYQzxJ0B1CTk51XUrTxu90GvrxYZE5lpVhfLXSnmVbd65rFAKEUb/3DmT9BdhErIQ
 PoOlmQtBV3CVigAKXeNNAgj9kMu25lwcZ6sXpwgkuxtDdtK3Xb0Zja8YN/BleXtiSM/EXqDRhwW
 K2XxZrntk5+jeQViVGfpY3SQTGyw0dL0CzMmtfdC05H3QxlvbkqOPjPhZ+HPqgD7l272clJEHkI
 1kmk5LQXzd1zGn/5BiWFD50wC2gUfmuIi1ENYnYkzVxsB/C2nsBmxFaQg7/BlGrtf2KP/0MrHKt
 Xo9fnrpoX0suAB4hlClVDL88S/lcQ1OKoL5VYw==
X-Received: by 2002:a05:7022:6995:b0:127:33c5:537b with SMTP id
 a92af1059eb24-1276acfdf13mr6634760c88.13.1772053727730; Wed, 25 Feb 2026
 13:08:47 -0800 (PST)
MIME-Version: 1.0
References: <20260210193448.69423-1-abailey@iol.unh.edu>
 <20260213193539.103858-1-abailey@iol.unh.edu>
 <20260213193539.103858-2-abailey@iol.unh.edu>
In-Reply-To: <20260213193539.103858-2-abailey@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 25 Feb 2026 16:05:57 -0500
X-Gm-Features: AaiRm52aReij80KOi3EP4cgQldzueVn_mJxKzDIkVxaWIeAtUIUHGHKSrZHQTJE
Message-ID: <CAJvnSUArdhT82tf2rZeJkMWpDPzc7=S6KcW0aYA7s+oiOwOH=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dts: add find float method to text parser
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: luca.vizzarro@arm.com, dmarx@iol.unh.edu, dev@dpdk.org
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

Reviewed-by: Patrick Robb <probb@iol.unh.edu>
