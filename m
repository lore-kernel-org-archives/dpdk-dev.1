Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD08D2ECF7
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Jan 2026 15:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3214240E3A;
	Tue, 20 Jan 2026 16:04:06 +0100 (CET)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 4600940E32
 for <dev@dpdk.org>; Tue, 20 Jan 2026 16:04:04 +0100 (CET)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-652fdd043f9so10159620a12.1
 for <dev@dpdk.org>; Tue, 20 Jan 2026 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768921444;
 x=1769526244; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qu9ojNPhsphXdOutK4iHgiFnYtyVNJo/1j46XdveW6w=;
 b=n8zsLH4vUItOCF1O9ytjscuZEmhLN79ANidgk0Cl8h1c8A2gV4tGGH02zoB/asyAT+
 pWC7APhVtHLEtDCtDmZkvtZxG6XOX6JkyzhVeUZcIKZ3OXz+c3n/Evp7+CBLk+xgKLEy
 F9FB1+0RuFWIBhzGcc8UzskaR55sUY46E/YKjl0a7Mz5Hv0+dq/vjDZkh7hiEdyeWgue
 oXA30RQh+I+Ff8BRR7LPerzJu4Pob18SCw6hhipJuKrBNK55+wKXQ586LcXXd+fg0Ndn
 KsZ5vQOwJRbJkM9Sy2B0SEdM7Q2aETs4pvxpS6pXSdXWElbpeP1ID7IE/0YuOCtg2AH/
 TePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768921444; x=1769526244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qu9ojNPhsphXdOutK4iHgiFnYtyVNJo/1j46XdveW6w=;
 b=dF+viF0MCV7lfvCwJGK5NgkrzBsEFZYH0AIuS45JxTwgsx8onlHzyg5O/VxfRAjiYk
 NTqnVwDFfl0lVye11E6sZ7vZxZoSwntLReQdGvQxv1Eopz0RbTY4BIK74N5OqaoKC3DY
 XMElYUMzIfESskDVqgIIDyBXInrYWJ2wZToDFcJsn1+56yKcdkK4Ada56phbPokf9JQe
 m8K72KCNIcE0WnDYyn5wcWJql473iOWnQsySVufL0FrUr5klWywQ6/COKdD8aqCJoCxJ
 3JhdT/9f2NY8ouZSm7nEaKpLsAagW3QAw9pv62tOha7iFLHus0WoS/fVVcFMfL8mp6nj
 b8sg==
X-Gm-Message-State: AOJu0YyLO8J0o6QFEuejoiiNbujzSVTHzhn0vd8BHqL7ATydbDGxI9/s
 zY9UDYoMhxytacPIQNjXuz38NpYjlvYrzP8vsZqkIvQ0wpPl7TRncgySAZoivk9jLoQ=
X-Gm-Gg: AZuq6aIj1hQxF4DR8gWl7vje5QZCaRbzBGsw+jwKo0z/HOMzZCC8U7VY/FBCAuHew/b
 d2xACU3QtGMyApsSPGOSWe6H0Q/4S5FTUVCnhxI/7/DtJ7ZTJxXPZNgjKMP2bneNuhb/PAEPqbp
 QPHFymCpbPQM6V1Jw9o7ftSWPkdU/gokMPR6TuSKYd1qijZP5hqwkeR3DTd2JGaO4lXFLm17OiQ
 2WMZH9qlaorlE1QMCrn8jgJDqDwX1XsKItgJ0VnOUyNFZc6RiX/a4f17MAph+sNpxoAdxs/rjey
 YzHEpPr+Pw55M9bYKWn6H7P1CjH7xPOMljhzkEp2TVElDuhchJlIM8ltpnTvuIy4wX+sZZAVf+o
 F4get/X15B3fhLdSznKl0t8YUwQGB/flwqFy8QcbXRFG0nLaBzcfKUeH3BQ/qcoihE3ga4p4OWa
 SzEjbBHAAPQeU/3cFwDp90D17qOcJFvA0OMUx5PxNobo/qtD+YINCG
X-Received: by 2002:a05:6402:5357:b0:658:1224:3d57 with SMTP id
 4fb4d7f45d1cf-65812244158mr34819a12.27.1768921443197; 
 Tue, 20 Jan 2026 07:04:03 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654534c8689sm12973797a12.23.2026.01.20.07.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 07:04:02 -0800 (PST)
Date: Tue, 20 Jan 2026 07:03:58 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, anatoly.burakov@intel.com
Subject: Re: [PATCH 2/3] test/eal_flags: add line numbers to error messages
Message-ID: <20260120070358.56bf69f0@phoenix.local>
In-Reply-To: <20260120112552.921243-3-bruce.richardson@intel.com>
References: <20260120112552.921243-1-bruce.richardson@intel.com>
 <20260120112552.921243-3-bruce.richardson@intel.com>
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

On Tue, 20 Jan 2026 11:25:51 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> To aid in debugging any problems, and because there are sometimes
> multiple very similar error messages in tests, add line numbers to the
> error message printouts.
> 
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Alternative but not required would be to the TEST_ASSERT macros
which have file and line.
