Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBAC02198
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 23:16:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D2D74028A;
	Sat, 15 Feb 2025 00:16:45 +0100 (CET)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2072440281
 for <dev@dpdk.org>; Sat, 15 Feb 2025 00:16:43 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-220e83d65e5so35183255ad.1
 for <dev@dpdk.org>; Fri, 14 Feb 2025 15:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739575003;
 x=1740179803; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=7AKdwmDLC8T3q0iAUgz4tsd2pXdfhmJehHrqzFrgFEo=;
 b=z/aGgbG+7Hb7kDTXHq9TXcq/6FVtT8UPFdpgdueW99b5iH63suxnAGpDxh7PUNpyjh
 gLikCByT2+Qm54XXFv92P+onXBCP8xE0TBV7u9JSRnP6jJh9RM7RxfK9NS3avsmG0y0a
 G+i+PpiXQbq3tQMYiS88CT8gVhX1rD2MAOeCMzqSPRA2OCAnYCmPPeosyO5UxOMbtxjb
 goCHIKf0G3NAjOca+gY2wWt6iBB2YeFp5IAo5zxUdXNSC6wC7Z9VDza+9rdbuK7Oafd9
 apBl/kAOaH913GllKPmkaFV4mRY8okldEx1AqPfYkz6UcncfQpSOvcmycvUxgx9y0rNz
 QdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739575003; x=1740179803;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7AKdwmDLC8T3q0iAUgz4tsd2pXdfhmJehHrqzFrgFEo=;
 b=cLo4N7q1pWv5BIG2nS1D8J6ZYzr/yCx8SEMBVw3ZnwEsfevt6PDbL4jc5Paa3w+Fub
 Pu9ptwY8kgwUSuyO2T93ZsT5DroAlxs0Y6uYc5MyLbQ04NxHMpsqPrl0CyrZP2v2GuU7
 7JUbbxC4IgEN2jPr5OiqaXmQRlzNlaj/dLIHO7r2cu1gXzIjDacp0IuV+qCze2dakIPL
 6OkfqtDrukCaE/Mu2yLgSV8oMuAcGuCICpPCC+AD2nL5QMF0kPLVc6JO4agw/EJxGWLQ
 vEgsI4nvlmropUwtrqL15BPJCcg67t3gRXzoGOyLHHJiZBwTZheyz0dmCiebAJavgFZa
 xvkw==
X-Gm-Message-State: AOJu0YzdrGYcZGoZPojFxKsICAJzjbNVwZga4rejrqMvACgpcHuszU5N
 xtyRGNAIa/UrH+YcSZ3nzdJnbbz0TiWbvpCr1JiZlKw+pJH11pFt34+rhTi7sPpkrS8HUvafflH
 W0wM=
X-Gm-Gg: ASbGncuzpUguObYXmzV0b/D1AucFN7lBBfGhKZirg5tCoa5+VqkiOLnxLsGocU5T59L
 Ko2+bDdDP6+4WYozrn2kfPk2VkDDWuQwnFo0Nn5ycrZJgmV6htKfSPQD2UExajW7L8F+GQRFZ2S
 QsFz5r1JJg3kVfic8KKrC7EHI/74iedrAVjBTaO8Uh1a6YDG8/OGO6NnrWl8n87xNWsQs3oUvBr
 KXsQdJiKJi91GI+Rf3HQqp/H4tu6JOYLVpOTr0deG1fJFSMsWTubsWy/jFAU1jwMe1uvUvDSxFh
 RkmMXTUhjRw7nVdGu6hsRnEdBkiwpWm8VRq74a4YYezxluzRqJUVzUICF6by3d/C2kZi
X-Google-Smtp-Source: AGHT+IG0iGAAZbcC+0oLzpq9VouosFaDUheZhBuEr24C/KyoxvFn4AH6yoGQCiffply2jyFo0XA2Rg==
X-Received: by 2002:a17:902:c947:b0:21d:cd54:c7ef with SMTP id
 d9443c01a7336-22103f05006mr17970445ad.9.1739575002833; 
 Fri, 14 Feb 2025 15:16:42 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366855sm34191865ad.94.2025.02.14.15.16.42
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 15:16:42 -0800 (PST)
Date: Fri, 14 Feb 2025 15:16:39 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: PVS studio output
Message-ID: <20250214151639.0e5d6047@hermes.local>
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

I managed to get a full run of PVS studio against the current DPDK main branch.
The tool supports many output formats, the most descriptive produces a full html
directory that can be read in a browser.

The output ends up as a 19M compressed tar file. Does anyone want a copy?
Or is there a good place to put it. Don't think sending it here is very helpful.

This is full output so a total of 10,000 messages!

