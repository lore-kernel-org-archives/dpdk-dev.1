Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0942FC5B543
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 11:34:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DB514279B;
	Wed,  4 Jun 2025 13:34:12 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by mails.dpdk.org (Postfix) with UTF8SMTP id E8D324029D
 for <dev@dpdk.org>; Wed,  4 Jun 2025 13:34:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749036843;
 bh=gZuath/qkKD9o/Anpg7yWB85iperEzQT0ytrAzc4tF8=;
 h=From:To:Cc:Subject:Date;
 b=Mhr/8lgsrk5ndjL9NCYxd8sqUgMpTLq27VIZ2uCdpLAId9rcdx9LORIv5Bj2MKkdU
 3ebmpR+54GFPBRZDHGkDa5mDWXxUJpKogP/8gu9+SQplJ/lEvDt3TqejW4Bzqu0yTd
 H85NWSMR4p0RtuMdSmVoAeodyey7HZgpRhVaxtPI=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
 id 8821FAEB; Wed, 04 Jun 2025 19:34:02 +0800
X-QQ-mid: xmsmtpt1749036842tgn4lopjq
Message-ID: <tencent_4DE2B6B9192CF530111E62D51D0BA7A1BB07@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u4M8eJlQfcAbAujr9/JqmDNf2rODTJdaNKU52qtluHQoi587+Cv
 /hMSHR04vqzPRQGMOh1WJx0XlJinrwQGywHMC48xYKrAn7Xlw1XPIblfkexf9n/P36Nwz73d5rY1
 JQFGn4SRxOSHN5KHySe8EfCjyQiRC7iXRKmdZeKVAs/a34zHZNahVksykntsbfw4/2yuEktwgz7G
 5hPRSLDChpom29HpuOMogStexD1lj7IBuhBvGKJCGG6DruD2JmVFLUzZnOA29l3fH10FoVy1cMYN
 RkeNoCHvT7fW1wGDdjezViQjNoxgQ/kkyScgF5DlKXvTUezaI9aukbRyOqtvokEIr+DfcXAKaBAG
 FyrZrVxrePC3O45OjGLcqGz5lAaQ8IcyyENo7HGPVRWKUqQ3Y+7KI+gOfB/o3OCwcYQ+Ef+ZE5T7
 xGrF66eQoew5xq+EBXqfEOAZgurruWDExjjSNAoyOllMPeGR8nLL193M+irBAJT3Nl4KKonxsOrg
 gn0lIGjKYIu6vN2zKF/UWgqfU2bD/X45kpj8cTHSZ8zWBraoblJbWVHCk9/SqArtyYcljom60mMG
 UDLyQWYDYW2kWSvrSuFnIAXg0ue4FLDdMBlsGIVFGo+JPK7ySMZnF/JvbXQVWwo+/JtOCBcLwtxs
 PoB4XzFjIhaSmdaejGf8UUfTVjidbIzcfk7Z9rykBv+CWfTdHT8gVjzVsRK5HD3SHvU5wQBkF4Pp
 qPHeadrR/ktBoYvRMCruwMDD8rpHKc0k0V/+6imqdB7FGaXLVs7GImwVj+bg7ewvWMhZvTUKFolT
 r1OdX7Ox6VE/rryEygYM6pHOhZy9aJpO7Ub+7Eir9T+V8CB214A5kcEXIEvtcNt86jQh/L2ZqaUA
 ntzVDwjBYEHXBWfOiu1cdVClaiqa1wJzFxcdNJwmAxhZjOp4auJX/qJcgIcbA74gCzehzRHwCtkY
 /nBrrtsAa5LfiELmO1KmIdTJZp9iYzy791Me5IXVxezZDfTtHGr0HcJYZ0QDsu5kKEG1rkz7Cy1h
 8T7CLkcXCsHgRZvhzyY/RsKzcvCXs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 3/3] riscv: override machine_args only when default
Date: Wed,  4 Jun 2025 19:33:40 +0800
X-OQ-MSGID: <20250604113340.1876914-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
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

