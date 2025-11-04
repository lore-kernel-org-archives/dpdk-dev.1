Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDA6CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 14:44:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16D5740613;
	Tue,  4 Nov 2025 15:44:29 +0100 (CET)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9BBDC40269
 for <dev@dpdk.org>; Tue,  4 Nov 2025 15:44:27 +0100 (CET)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2957850c63bso27665745ad.0
 for <dev@dpdk.org>; Tue, 04 Nov 2025 06:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762267466;
 x=1762872266; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uutKCP93lx762bvJgP5CTVvVBcmt81txrQGFqM/IHM4=;
 b=Jp4aXk7YANv6ANdbYlmPFCc6GtanniLIFJyCGSBQn/jnbMWP0x/8SQrvJ5XYswP7sV
 Jr3Di3Mx2p0qi4vRoXhvalxwxBi0ay0aScoO0atcg0YeygjAO2roCfaUPfqR+0TScLg1
 CGcV6/S+DmmYLu3K8nck0XvSwSHFfxxgLl+4UJiArVDC57NrPpjeO5R8KC6Frkjhhh7n
 rYhEl2ajfxKmKT8TLHphoVjRoWS+EjYja7PC3asTQjB7z3WM2A6lAt0GhjBHBDdh/M00
 uGIeva9hvpIss0j1lmQ7m6x1qGmRec1JIFZpJ6Dgap0XM9dTuZBym9QllWuDC4C+1yWV
 pxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762267466; x=1762872266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uutKCP93lx762bvJgP5CTVvVBcmt81txrQGFqM/IHM4=;
 b=agKODRvriAzP1WDNWmLtiW6DbRA3UFkXO4m5qU9HHCvRHmVzN5P6RILvYGSszaZAJb
 UCzXeRxYbWC2jbVF4RH9QLQWuDOZ77eKJA18aXBbud7dyPuYRhEFZLJyPKqJosozEYbM
 8JMAhECNPe8aTuNvE+jNZ0IRlRY954AimIWe+LWJ3RGEhTndmjAJIwst+A+nxV23RVrQ
 ydZIGm8vT0EAfKslGzK9OOtBVlpU271JgrXQApheZFpVHaNbN7T/JeHkyZyAmOi5qO2N
 YtZ16GCmim0bEeXu98UIYIcIkCmpUXSwYx+5LXnBOnLY4QZPsUesH370fRIl8tbkV50f
 a9iw==
X-Gm-Message-State: AOJu0YyKTqRM62APg6NOSH9KDCaRMHuJryldwSanbYPtfyLq7vXG6URA
 iuc94wvWVTkWTqTHgM7jB16Npomv0J/Sg0WHmofylAXggROOWcNpJHqc7+ybF+rPV6Hmjeu6lDw
 0/c+U
X-Gm-Gg: ASbGncsK5aU/MTp19uT07WFKZjWK4xUTQ3o6LTKh9uT4bwXlygiQ54u6tlPi5jJ/0s7
 ZKWPwQnpMg4LeDOpoEl42L7VyDFozFWRKwnFihcM+Zj8XbIv60bNg5IopzeGAQMpPwyQRdOTx1l
 0h2tSPU+NYUgRI9qR+oH+mJSKiLf1+8JIV9+B+/g0N1CV0gj+yT7NFHgrdYtKb36eBWlpTS7Id5
 5O1XoyDALpJNe4Z7B9RCbPWPnVJNxL2oMo4JdA+HwTNxr3yV/Cv0+YKj7WZtD9L7nAWbKk8NQ5T
 riIIGFWIfuFkV+56ZrfmsVEqpQmb4Ps9if330oTY+6unQ736ZLLQHlg/J4Yy7QMPOodTudx+ny4
 BmUYVpuPdeDnwDO9PsNTUQNzqatjl5EE600n2ZquRHbeYRq0lMfA3qLiZd/Oh0d7tqhhSJ+ZSk4
 JLwHHjEDMuj5fWC7dGvwgAetTCC1K5bczrVxdhK5yVSc29
X-Google-Smtp-Source: AGHT+IHTLoSVgXfj6tLf28fV5h5bl6A/dwf4AEMM3ft7y36i8HME6shN4FuunHk4veG288L/Rgo7IA==
X-Received: by 2002:a17:902:ce8b:b0:295:5da6:5ff7 with SMTP id
 d9443c01a7336-295f946fc18mr45442835ad.15.1762267466272; 
 Tue, 04 Nov 2025 06:44:26 -0800 (PST)
Received: from phoenix (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29601a60761sm29213225ad.90.2025.11.04.06.44.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 06:44:26 -0800 (PST)
Date: Tue, 4 Nov 2025 06:44:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v2 1/1] net/nbl: use hardware MAC address instead of
 random one
Message-ID: <20251104064423.736a909e@phoenix>
In-Reply-To: <20251103033028.3474579-2-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20251103033028.3474579-1-dimon.zhao@nebula-matrix.com>
 <20251103033028.3474579-2-dimon.zhao@nebula-matrix.com>
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

On Sun,  2 Nov 2025 19:30:28 -0800
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> The previous implementation used random MAC address for rte_eth_dev.
> This change retrieves and uses the actual hardware MAC address from
> the network device.
> 
> Fixes: bf649059c5ea ("net/nbl: support init and uninit")
> 
> Signed-off-by: Dimon Zhao <dimon.zhao@nebula-matrix.com>

Queued to next-net
