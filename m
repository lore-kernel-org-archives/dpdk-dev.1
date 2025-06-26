Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665F0C7EE30
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 19:56:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 926D240655;
	Thu, 26 Jun 2025 21:56:24 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id D07484026C
 for <dev@dpdk.org>; Thu, 26 Jun 2025 21:56:21 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6facc3b9559so20907946d6.0
 for <dev@dpdk.org>; Thu, 26 Jun 2025 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1750967781; x=1751572581; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjEVE7cYdAugUz0dlzVllAH98T8s6NuUXvhHaKr1c30=;
 b=NwezR+JS7YK2V0wp2qBcgh38w8VJ8/4ovOqVlvbdrEAcfmxlRo9NaVEjI8NL1o9ZMs
 U0Z+FMuC0AUHL8GbCgWEb+M5rtrhXDrSRSo4NkWVOGZVU8iDdX8txz9WEgxwGf76ZYc6
 v+Iqmm39YZGl4uhJhFrctkIyJhTkbH1CEc0PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750967781; x=1751572581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjEVE7cYdAugUz0dlzVllAH98T8s6NuUXvhHaKr1c30=;
 b=A2ziq1MlD4izlUy+HDBMs5JINeDEdCVuKq3GX1CbjeONi2pygn0Gn+wtidHl4aYEiw
 eUc67Gr0gqKk7Ofy79oFUER4f+PwES5TwnJsu05Jnfw+JzS0wIjDvq9taIpYudVeRj8O
 yY+JLnAAbwrmhO5BsXEOVWuah57VWxMxqUfjuCvoH+YKIEt6uy6Xw7u5AqAi945M6C56
 w9EFQIXmfaG1UUzwvO4ZQ/klCJcZh9FtTwHDV0djQESxK9kPSIK2oIxtClJYQNllEX/J
 N+FNohiqvLKKsjM+sYk/FQsMKte3/iVXEGh3Aw4R0BkTM4fOzp6pyNqrE490q/8zHTWr
 2XDQ==
X-Gm-Message-State: AOJu0Yz0CqXQc8jj+m4iFqqutisSkkh1poqKa+kcgiP/ZWbMrtbHuUEJ
 b608ZSu1pdwc7n7H7T+IacQhG5mOHvhi+PuTE5kvLCfy+w9QuT0rp0vnetTdpyhGol4=
X-Gm-Gg: ASbGncu6LXmZhjeeXsXUgt0KCP97mbyVzoiAfNX0Ub2b+5h7lq0sADimIX7OubZPROJ
 X2lYFmcLL1DCgdpNr1dO7wz0CjGlrXjS1dLD7ACI0j/lq5+txNAXQtCj9fklqIJp2gOTAmimKQq
 ePzfaRDBRDltBN1e7xgBhPe7WhvaPG0iqdA17HYvMZcJpC8ojpy4dAAs48nQuTFwQLmLgUHssIy
 kTJsHetkvBchP9DRkJ2Z0dsM53k0XD1K1gI9ggcfkxxzs7WcGFwkwJ8XZn5gdhAACmuMIG1C+B2
 bhhDoE5naHpul+Rz7hH0utBcyMpr92o/WFBZmvimFiTlTdBXz9JV6Y0R+1WJHjLEG1Vs/LZ6
X-Google-Smtp-Source: AGHT+IEm7ACu1ZpQO1Euk1diiivlcAA++8LN48p5hJxKEll9ngYb2+7RrUCuk7mp3knkjzHzNhw54Q==
X-Received: by 2002:a05:6214:2608:b0:6fa:cce8:3bdd with SMTP id
 6a1803df08f44-7000291701dmr15744936d6.36.1750967780919; 
 Thu, 26 Jun 2025 12:56:20 -0700 (PDT)
Received: from fedora.iol.unh.edu ([2606:4100:3880:1271:ac5d:4186:4dc6:47eb])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fd772fd163sm10991006d6.94.2025.06.26.12.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 12:56:20 -0700 (PDT)
From: Dean Marx <dmarx@iol.unh.edu>
To: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com,
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com
Cc: dev@dpdk.org,
	Dean Marx <dmarx@iol.unh.edu>
Subject: [PATCH v3 2/2] dts: add flow validation
Date: Thu, 26 Jun 2025 15:56:17 -0400
Message-ID: <20250626195617.219395-2-dmarx@iol.unh.edu>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250626195617.219395-1-dmarx@iol.unh.edu>
References: <20250521192629.294265-3-dmarx@iol.unh.edu>
 <20250626195617.219395-1-dmarx@iol.unh.edu>
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

Add a method for validating flow rules to the testpmd shell class.
Implement test case skipping for flow rules that do not pass
validation.

Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>
---
 dts/framework/remote_session/testpmd_shell.py | 15 +++++++++++++
 dts/framework/test_run.py                     |  3 +++
 dts/framework/test_suite.py                   | 21 ++++++++++++++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/dts/framework/remote_session/testpmd_shell.py b/dts/framework/remote_session/testpmd_shell.py
index 0b9bb4070a..299887dd80 100644
--- a/dts/framework/remote_session/testpmd_shell.py
+++ b/dts/framework/remote_session/testpmd_shell.py
@@ -1984,6 +1984,21 @@ def flow_create(self, flow_rule: FlowRule, port_id: int) -> int:
             self._logger.debug(f"Failed to create flow rule:\n{flow_output}")
             raise InteractiveCommandExecutionError(f"Failed to create flow rule:\n{flow_output}")
 
+    def flow_validate(self, flow_rule: FlowRule, port_id: int) -> bool:
+        """Validates a flow rule in the testpmd session.
+
+        Args:
+            flow_rule: :class:`FlowRule` object used for validating testpmd flow rule.
+            port_id: Integer representing the port to use.
+
+        Returns:
+            Boolean representing whether rule is valid or not.
+        """
+        flow_output = self.send_command(f"flow validate {port_id} {flow_rule}")
+        if "Flow rule validated" in flow_output:
+            return True
+        return False
+
     def flow_delete(self, flow_id: int, port_id: int, verify: bool = True) -> None:
         """Deletes the specified flow rule from the testpmd session.
 
diff --git a/dts/framework/test_run.py b/dts/framework/test_run.py
index 10a5e1a6b8..fd49a7dc74 100644
--- a/dts/framework/test_run.py
+++ b/dts/framework/test_run.py
@@ -655,6 +655,9 @@ def next(self) -> State | None:
                 return self
 
             self.result.update(Result.FAIL, e)
+        except SkippedTestException as e:
+            self.logger.info(f"{self.description.capitalize()} SKIPPED: {e}")
+            self.result.update(Result.SKIP, e)
         else:
             self.result.update(Result.PASS)
             self.logger.info(f"{self.description.capitalize()} PASSED.")
diff --git a/dts/framework/test_suite.py b/dts/framework/test_suite.py
index e5fbadd1a1..145b79496f 100644
--- a/dts/framework/test_suite.py
+++ b/dts/framework/test_suite.py
@@ -39,7 +39,7 @@
     PacketFilteringConfig,
 )
 
-from .exception import ConfigurationError, InternalError, TestCaseVerifyError
+from .exception import ConfigurationError, InternalError, SkippedTestException, TestCaseVerifyError
 from .logger import DTSLogger, get_dts_logger
 from .utils import get_packet_summaries, to_pascal_case
 
@@ -411,6 +411,25 @@ def _fail_test_case_verify(self, failure_description: str) -> None:
             self._logger.debug(command_res.command)
         raise TestCaseVerifyError(failure_description)
 
+    def verify_else_skip(self, condition: bool, skip_reason: str) -> None:
+        """Verify `condition` and handle skips.
+
+        When `condition` is :data:`False`, raise a skip exception.
+
+        Args:
+            condition: The condition to check.
+            skip_reason: Description of the reason for skipping.
+
+        Raises:
+            SkippedTestException: `condition` is :data:`False`.
+        """
+        if not condition:
+            self._skip_test_case_verify(skip_reason)
+
+    def _skip_test_case_verify(self, skip_description: str) -> None:
+        self._logger.debug(f"Test case skipped: {skip_description}")
+        raise SkippedTestException(skip_description)
+
     def verify_packets(self, expected_packet: Packet, received_packets: list[Packet]) -> None:
         """Verify that `expected_packet` has been received.
 
-- 
2.49.0

