Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D22CA0EE0
	for <dpdk-dev@archiver.kernel.org>; Wed, 13 Aug 2025 14:25:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7018840657;
	Wed, 13 Aug 2025 16:25:38 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id 080E740265
 for <dev@dpdk.org>; Wed, 13 Aug 2025 16:25:37 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b913a76ba9so1724720f8f.3
 for <dev@dpdk.org>; Wed, 13 Aug 2025 07:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755095136;
 x=1755699936; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOn40hJGHfxKauEFZLHE4IYsXkK5oiaZxKtC1OphwWw=;
 b=reBK3w/bnGsgNkP2gYS37KSLLC9s/osUSs0KPokXDaQlGXVlO0Clzfapwps/GHrCV/
 sU/nHuMR+tWHuu9hCzqEl28g3k7nDRd1FiqiKBobA5a3FwIT+zR3ivpZ2eS5sZ0ltT4H
 fuk7mDp5XG5z+59f1g0gmGWWRYAQKciqyIJEbXzkgGh2fqQAuAW5AhZlYtkUAhAxBLyb
 LsPbj9rvonVzQmd9x/re9C2kuERJCkgTurpKphVzaRTGtDpIkiLixeX1WMVcQXeTrufT
 da+7Fj7j7r93A0iDR3HB0Edp7RWK9rrcTTEZH2is5uFD1hu2wgFu5BNK8FkZFoQBvXu/
 zN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755095136; x=1755699936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOn40hJGHfxKauEFZLHE4IYsXkK5oiaZxKtC1OphwWw=;
 b=i3DFXZMVyA4bb3TzzsBkDUQdaBhM15y4INjg14QRcxQc8wDs2Qah4qbxI5pkv6Y/Lw
 CZWN0Im+FeKUMUn8ciNd0IKkLVIuVPG+QYh9p1VFFu2PhcAi5ljAG1sVaHnNtZuWgsxQ
 BPDd6plAukaA/A6nWCK4PpAB6Ltv60/8evpWNJFGh3SF0hktffHS86WSAsfvritQvxbI
 uOBc47iisqEKdo/MDaceTkBlH+MCMa80CWl1H2g/k/Dbk4N9MXb9+r7nRHJ/TC2yMqUz
 GiQOvbJbyPwrtMtYxoAkYtGmq4Sfj6BpFWIlCOmdNVY5C4xZA+LG4p5s5cJ122bfw885
 EE9g==
X-Gm-Message-State: AOJu0YxxEuWzdidD0CpstfjZ4wWBeQi8jxVwDjJAVZoZtn6DUSKkUYxL
 J1B1A6Y+bJMuBkSVXTvhRTUMhvbrWIOMGVVSWPz0iLUmcYXrDQ7V0ukh2f6N0sS7FyA=
X-Gm-Gg: ASbGncuctMdvGon66ku2Kz8dJ/YzK/JjDRjukwcoVhaPel9tV1axUNMa4QP6F/ra+oc
 rdeontilLltrxIYfAgiPq+rPV/5N3+gb0G7XTNZ3u1UN9jD2db+FYAyGkJC3PtQbWtOw/FWOvpM
 rcLGZG/nZp3zNwvQo4nH1Ki9cOIh977za5L6FhGiX3I87z+D6iN9kA549vy4AcMGPR4oaXzdVNb
 W/64PYpKO/cg3GzQJhvZg51iTohEssvyjpakY9U1CKJk1h3w0WHIaG5WTsjE3WzLM6nQrwt7U/R
 AC6jahqi8vzpwJxIO5GxBU5yKfizcrOLPmtNGoT1gBqB1fyQruzIjES6gD3vhI5ZKvGNPLc10a5
 LH6dUuOH5BvDUnGHf2YLEoS1FH8KGOElGNdT03aij/srdhPeVB3wlVpqOkpaV8GwANr/6SNzcDv
 s=
X-Google-Smtp-Source: AGHT+IFUdYjVbOhP+Q6H3gOqlqAdxdqk/XL3wCbm+laRQf/bZYowvwJPk+x2+E1/swQ6mwMv8pnsQw==
X-Received: by 2002:adf:a456:0:b0:3b9:1dac:70e with SMTP id
 ffacd0b85a97d-3b91dac076dmr531995f8f.55.1755095136514; 
 Wed, 13 Aug 2025 07:25:36 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8ff860acbsm21563770f8f.51.2025.08.13.07.25.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Aug 2025 07:25:36 -0700 (PDT)
Date: Wed, 13 Aug 2025 07:25:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dimon Zhao <dimon.zhao@nebula-matrix.com>
Cc: dev@dpdk.org, Kyo Liu <kyo.liu@nebula-matrix.com>, Leon Yu
 <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: Re: [PATCH v4 04/16] net/nbl: add Channel layer definitions and
 implementation
Message-ID: <20250813072532.553f76db@hermes.local>
In-Reply-To: <20250813064410.3894506-5-dimon.zhao@nebula-matrix.com>
References: <20250627014022.4019625-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-1-dimon.zhao@nebula-matrix.com>
 <20250813064410.3894506-5-dimon.zhao@nebula-matrix.com>
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

On Tue, 12 Aug 2025 23:43:58 -0700
Dimon Zhao <dimon.zhao@nebula-matrix.com> wrote:

> +static uint32_t nbl_thread_polling_task(__rte_unused void *param)
> +{
> +	struct timespec time;
> +	struct nbl_work *work;
> +	struct nbl_work *work_tmp;
> +	int i = 0;
> +
> +	time.tv_sec = 0;
> +	time.tv_nsec = 100000;
> +
> +	while (true) {
> +		i++;
> +		rte_spinlock_lock(&nbl_work_list_lock);
> +		RTE_TAILQ_FOREACH_SAFE(work, &nbl_work_list, next, work_tmp) {
> +			if (work->no_run)
> +				continue;
> +
> +			if (work->run_once) {
> +				work->handler(work->params);
> +				TAILQ_REMOVE(&nbl_work_list, work, next);
> +			} else {
> +				if (i % work->tick == work->random)
> +					work->handler(work->params);
> +			}
> +		}
> +
> +		rte_spinlock_unlock(&nbl_work_list_lock);
> +		nanosleep(&time, 0);
> +	}
> +
> +	return 0;

Adding another polling loop to applications is bad idea.
Please use some form of blocking operation to wake up the work handler.
