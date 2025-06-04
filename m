Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C7DC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:49:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 189A542DC7;
	Wed,  4 Jun 2025 13:49:39 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by mails.dpdk.org (Postfix) with UTF8SMTP id C8DF542DAC
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749037765;
 bh=gZuath/qkKD9o/Anpg7yWB85iperEzQT0ytrAzc4tF8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GG01asYHuODbWedpkCe6Nn8x4SHJhn74D7XzR8hhBNXHrtlrqHRdme8p9TheIRiEs
 a9rLJJgDubp7XFfnFX+RhcKaC5Fkb5M5si48S7FB0ScdtGK5ib00ElfLefaioLdekt
 9jro0/fmeLp1U3hox5fhsIp5GuTdOo+F5XFkqHEI=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id C579EC83; Wed, 04 Jun 2025 19:49:23 +0800
X-QQ-mid: xmsmtpt1749037763t4h29oobf
Message-ID: <tencent_C59E12D5698BABA18762CE39452CD2301007@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Gtn8bHIyfkkDjB6j3hnd/7+K5K4v8pilfk8NEUL3cwrXXGYQTVt
 PwVr8dzDYqhZpugN31v7MVkfKp5EOo9n6w+VuU0OHUGapJr+LtI4D59daa/S/V7jvEL2sSb/kAab
 xRIUCIlqKlPMyoeLsE3RhpAP2s4eE0TUzvdpn8/rFznYshpCLg614f1Qd/okGiVFbyJ95pZHzFNp
 CNzVmHuFvY1yKzvjLgHphY+Ei1q83lxLgfFEBKuS3l+rXNrBlla5PQVVhp/PmU/16k2LLm51VvB3
 73i+L1+BE4oiCM32oYsfZhG3q6JoHBPkpd4qPrWELqJFXb1YCRdMlhHhJSBcgIQEZ1YW464v2K0/
 sjfF1OpqNZJ/vFakrZQmC4g6yKvXfySq+RNEmk9pLPUDhVwHoscMSd2pPcgYh40uQKYOaYgFi5hP
 Up+afVy/ZTxdqmAHvbOMfmUFITF4DbKDbxXXlpP0z8YnCphj3No7S27BWovCx9XRH7lK1pVRIwcU
 pNdAkiQkj1Socw+oScSr1TZaGVB/0l1URuog+dpMfsYjtUZcO4bK57S+tpqMm19B3K3Usw1ePMMU
 Dfw40QD1r+QqcvCQf7nissNjMq2uuJf/IgQqbEnKxzXjOZmoeiicLT9PdM6TV3OH6McNCHttcdb0
 4b4X9PUEN+ZPq/8tvQYfdOWP0OjWZcvdrQraf2L/TX/RaMAkkH7YSfh3ArS92zpeUsX8NC6Qa51f
 GRx5uSQJXab8iY/9pajvsTioWnE6UTDuW8BJtWpKAxeFby4h7w/qas3XzLwIXpjtiEUFASQBUrqQ
 DJlW7PY4sJudD4NhpAXnvow5iKBFiG7JAHiDVXX6MBnwYUJG2z3OK0XpbV8GaSaGU08WGy/2uqvT
 STYgjDwDDXXXnKqHshhjV88ZsqFMsEFJdi467oacFGh4cOoHa5ALw2DBHK5R497AzqmrHlPyOxPs
 ptNKZrFM1chvwOIWUDjQ5wuci0jTuFcfQ4U5qf9We9/wfJU6O27k6wFREWYjH9AglRplTgQjriDx
 L5yQ/uo1zVkpyf3hoyL88syBxyEW8=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] riscv: override machine_args only when default
Date: Wed,  4 Jun 2025 19:49:22 +0800
X-OQ-MSGID: <20250604114922.1948503-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
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

From: sunyuechi <sunyuechi@iscas.ac.cn>

Support using -Dcpu_instruction_set=rv64gcv to enable V extension.

Signed-off-by: sunyuechi <sunyuechi@iscas.ac.cn>
---
 config/riscv/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index e3694cf2e6..1036a86d05 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -111,6 +111,7 @@ arch_config = arch_config[arch_id]
 # Concatenate flags respecting priorities.
 dpdk_flags = flags_common + vendor_config['flags'] + arch_config.get('flags', [])
 
+if (cpu_instruction_set == 'rv64gc')
 # apply supported machine args
 machine_args = [] # Clear previous machine args
 foreach flag: arch_config['machine_args']
@@ -118,6 +119,7 @@ foreach flag: arch_config['machine_args']
         machine_args += flag
     endif
 endforeach
+endif
 
 # check if we can do buildtime detection of extensions supported by the target
 riscv_extension_macros = false
-- 
2.49.0

