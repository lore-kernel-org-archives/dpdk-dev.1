Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A065606A31C
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=OLFAtIds
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7B4940DFD;
	Mon,  9 Nov 2026 22:32:21 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 509FD40285
 for <dev@dpdk.org>; Mon,  9 Nov 2026 22:32:20 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2e9d1114320so10663645ad.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 13:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794259938;
 x=1794864738; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YYnjuYrKp7FETEwOE2qWkL4GlIjrexshz5ziNjbC3bM=;
 b=OLFAtIdsa5Meu7WK4Rv41hT/QtI7DrfD6wsIKVmWNJM+zC8N7tr9huIhM776Df4cr8
 rB4VSHqkcO7CB4sivgGu3XeMTDE0QmUTdlKOuvEWq3VpwAfpMigsJ9n6C/wITIeElo2W
 7AsAqyTfEItqzEMv/AUBnw9C2cnBrlZe4x5HGPIJ2rJB6Pl/rgcz0+u3OBpwzScgN0hK
 wNpbrWLN8Ta06rK5WNumOVJEjYXkhRRvvUD0+D+z2cKNuKmwzNT/IaMeixOU7ZymYeeW
 LpIhKryXnyGdfAsmTESf0V5KU3FB5Czh2UNiZlAz65p87/Cz0kCwevkNFbxtxkAtWszx
 wteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794259938; x=1794864738;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YYnjuYrKp7FETEwOE2qWkL4GlIjrexshz5ziNjbC3bM=;
 b=go4U6YVmG3KlZ0tuEW1zpEHwH03gd7QQtLZIrfE5yLmY2UZ8vSfUrKN7NzKrE6TW3R
 EZVZXqOt9zIM9LKhlQ/4Ai3wtyS5F3kL2TDBkzgxr6+Y/CdLxk9vJlLleQvNNKPBNH5f
 /vFqiQ8/vxUE0VFEKz/ro5kLHoYars5Yr3jJQochtJvl8IW6+zpIHFKB44YBCSesNLyZ
 mu7lhdF9n474wveolHMgjON2C9vErZuYFRoq9cFiFaroDUfpJ3Hi9tzK3cHMa7j4U2tc
 mSNJbZiHufuL0j92NvfVDPpz/pF1XvzMEHN+o1tXtD2BJ8Zbpgi+nl/+Dq0OuMiq0uzc
 vYQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHgk+dWzz/IuYviSskc7/eGRvHz48cGBc5oHugVbRlchxfdn6E/W2KloSw73lXT+5T4pzU=@dpdk.org
X-Gm-Message-State: APuU4Z+OU/Ogs7DbqoyOeu4bSgcRqVSk3Mnm4B/qYaUdNd9oDHMm4gS/
 BnfKT34Zy2aq0ZaRjOyv2s9XnvKG9oEdw7tt7DKAH9kYq3AAwRFfAdHZC6aQ9d91O0g=
X-Gm-Gg: AYBFou39J0D0dSFMKe+yYH+Unse0iaVgEqKKoBpLMA9cEfVkcWVpv/dzj6dlf80N5fH
 7fMnB5hYojeCm4ihRB8aJ3VKXlUA6GY94rj+eFoBcVwTohvFXdljo7pQYJBkPFnQXk4FfXSOSsf
 35N5twZmUDIRzNk+6+e/chA4hZNOzhHZa9sAohskzqwCpspznO5c0MlHqAOOTiNkj73VASvjw5R
 kLOZ6WIIPkGKtHL/YhiZbtLSj6wIErYBG5tZld4WP9AGTg8hPGxfBzlLV22q1rRBGUds0rdFXJF
 O7+b28BNTldY2L+eIxa6SbcSTna45hUyY3YYDz/0c+ldG4LoED1H+VKQX3IqaVb6Oc6+XkVp3be
 n95sdBoYnowvqMkSG6nfMzEHkvyJ+DLQze7DUNKzMiNgYYiotY29Dbsoj4C1RRFih3s+qa8TNgj
 ygJiQo71inoxbEsMmKy17dRSRA6zFlEtcG+JP9XNBtkIw9DqhEvRcMCnNH4T8OMTzZ2IaRZJq19
 rAISBhG8sLLP9+GmKFth1A1Igib8zs8T7+tH1u9GZjG/BuOMQBPm5t3/ntWxJDUITp5I3AhcJYa
 PwpMbemA9EYCxo+qZcB+PafgVoDf1QY9jHgVlKhjkvxzJXjF9fKt42EhK2zZG18RKqMDlQ==
X-Received: by 2002:a17:903:1a2d:b0:2ed:1cf0:4cdf with SMTP id
 d9443c01a7336-2edb928a514mr3507725ad.60.1794259938523; 
 Mon, 09 Nov 2026 13:32:18 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edb6d7eafbsm2050005ad.36.2026.11.09.13.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 13:32:17 -0800 (PST)
Date: Mon, 9 Nov 2026 10:41:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: chengwen.feng@linux.dev
Cc: "Shuaisong Yang" <yangshuaisong@h-partners.com>, "Xingui Yang"
 <yangxingui@huawei.com>, "Chengwen Feng" <fengchengwen@huawei.com>, "Hao
 Chen" <chenh@yusur.tech>, "Min Hu (Connor)" <humin29@huawei.com>, "Wei Hu
 (Xavier)" <xavier.huwei@huawei.com>, "Chunsong  Feng"
 <fengchunsong@huawei.com>, "Ferruh Yigit" <ferruh.yigit@amd.com>,
 dev@dpdk.org, stable@dpdk.org, liuyonglong@huawei.com
Subject: Re: [PATCH] net/hns3: fix hard-coded default value of UMV space
Message-ID: <20261109104133.58a16f41@phoenix.local>
In-Reply-To: <6b58c0ca561cad60abb0f7105b15e16989b80068@linux.dev>
References: <20261104124033.3373452-1-yangshuaisong@h-partners.com>
 <6b58c0ca561cad60abb0f7105b15e16989b80068@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 13:04:37 +0000
chengwen.feng@linux.dev wrote:

> Acked-by: Chengwen Feng <fengchengwen@huawei.com mailto:fengchengwen@huawei.com >
> 

Mail address got garbled in your Acked-by. Fixed during merge
