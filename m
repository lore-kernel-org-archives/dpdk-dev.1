Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401CECCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 18:09:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C78540653;
	Tue,  4 Nov 2025 19:09:33 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 3AAF840299
 for <dev@dpdk.org>; Tue,  4 Nov 2025 19:09:32 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7aae5f2633dso2539843b3a.3
 for <dev@dpdk.org>; Tue, 04 Nov 2025 10:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762279771;
 x=1762884571; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSFS6Xja25kswmX5YHSMeQ3EFy5NE/0X5r6+3S33NNE=;
 b=27nosIBQ5hoGccRWxGRACjf6B+8c0xkCzWhN1BVsPX0tcpAtA6HXwg0o8DdSJFKhrO
 A3u24sEH5utsoF+pHTm+YRXgjxprvs6pfu4G4eqmqT7+KGg7J5xvABtnZ1Uyg37fWazf
 ZTnhgE3FZX6AAKdwpRqNkFR4HJNb2jrUvf72uUOAD1NfbnZ/ypJfX/6PA1RU7UF7kkAa
 7oJ8nDKNznPkFKV23ORt4h6eYCtDJKgzbjXm1r7zG40U4p4FbbduxU5+IFlSlCSb1kdI
 lEOGlT5nBsKK0lGM1ke/7l194cjfO6jIcYKsTwrgN5djW6GKegfjj+gRHAYKb19q0w0X
 kr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279771; x=1762884571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VSFS6Xja25kswmX5YHSMeQ3EFy5NE/0X5r6+3S33NNE=;
 b=jkUBpzK1CfMwCTa4Or82T8ZscDt2wTXlU6oGlNjrB91KeCLg/4vSuZiMqOLF0Rmihz
 Ris8CR9OPuX9ncU9jn5yPSEwT0Vomh++mMIgQJRiJ+5wT1BQO6yUXWewRfe2PfqCb/aE
 K3FzrO0VXRTmVfPpPDo9PTU+Pl10L62dVkyaYTiOB8/CiZELwvDC8EChyxwNMR1+sm2x
 imW+XQhkZ95lfHUnIQ4uP5AuPg+60aAjcKfJqwy2bpeuUwn8WgOqGoH/b6lacjIA4c8c
 yasvshIt2FitbL5mblWqjJiM1GqQE+J1ZpLLR7vXBjOF1JKZPxudpHMEJ1oN3QSQd6I5
 WXIQ==
X-Gm-Message-State: AOJu0Yz930BAl8RYGGMnpUWefqJe4ZvE8sMfuSMisrOqeVri+tEN2SGE
 TkZVkrds7cfALlC+S9fknKC+DNzuEt7SRNe1Bgm8QiB4fpwnB8gttYuNgxO6jvDkt8lnAWEwwJv
 ODJXc
X-Gm-Gg: ASbGncvh71ZWjZuDFqwiUqYwhpzNHBzBjWTvH+0TTSEEhJGlVdUAWG4qL02jLzqB6K7
 RGiRWV6It0a+rx7JCTq3TnFzheFw31WKZuruptLMgYqYwonheN8cfWL4acco/QxEuXLCSbbm/kT
 T7RMD2K8L39ADLp/dpGaLra62yZi6ifR5fRdyWkf3gUYmFoyygT5lbp0Cku6ZPf+LtCNm4B1RiG
 UiyU5tNJF+Q5E+dRQGlTPNR1tmqjsGIGYAn6h3ZSyygHfT0eKIvypGQzAmHGYgaF1BgunXTQHMf
 P+LcVlgyDg3Ct7xwfju1MrU3XjC73jG9XCe2EVoxPqOHJWcS5o9IZJ543pz6n+sMC1KZ5447mUk
 Ol23EBkiotq15jv9ETXVdNcl700FTDVoOT0bem0JGQl6VTJ09UnQkIHux3zq/ZGpKry5TEzpIC0
 M7OF3s8Io/fayL7pjvI62ZuTI/3EaOH7/xXINdCY4=
X-Google-Smtp-Source: AGHT+IEy26xOMV5o8ca3H9dFf5DST8uxc7LbB/RsgmkJxKAbwHGsBVzB7F6pPJLK8L/QO5qVY+sHvA==
X-Received: by 2002:a05:6300:2189:b0:342:44f3:d1bc with SMTP id
 adf61e73a8af0-34f8580ba48mr184896637.35.1762279771302; 
 Tue, 04 Nov 2025 10:09:31 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ba1f86b0688sm3035988a12.28.2025.11.04.10.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 10:09:30 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>,
 Reshma Pattan <reshma.pattan@intel.com>
Subject: [PATCH v6 1/8] dumpcap: handle primary process exit
Date: Tue,  4 Nov 2025 10:07:05 -0800
Message-ID: <20251104180927.403355-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104180927.403355-1-stephen@networkplumber.org>
References: <20250811213632.16023-1-stephen@networkplumber.org>
 <20251104180927.403355-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If primary process exits, then it is not possible (or needed)
to cleanup resources. Instead just exit after closing the
capture file.

Bugzilla ID: 1760
Fixes: cbb44143be74 ("app/dumpcap: add new packet capture application")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/dumpcap/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/app/dumpcap/main.c b/app/dumpcap/main.c
index e5ba36350b..3621c0ebe3 100644
--- a/app/dumpcap/main.c
+++ b/app/dumpcap/main.c
@@ -1059,6 +1059,10 @@ int main(int argc, char **argv)
 	else
 		pcap_dump_close(out.dumper);
 
+	/* If primary has exited, do not try and communicate with it */
+	if (!rte_eal_primary_proc_alive(NULL))
+		return 0;
+
 	cleanup_pdump_resources();
 
 	rte_ring_free(r);
-- 
2.51.0

